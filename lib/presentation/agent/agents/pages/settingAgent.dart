import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final EraUser? agent;

  SettingsPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: EdgeInsets.all(EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EraText(
                  text: 'Edit Profile',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/agentDashBoard');
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            agentProfile(),
            textField(
                labelText: 'Full Name',
                hintText: "${agent?.firstname ?? ""} ${agent?.lastname ?? ""}",
                isPasswordTextField: false),
            textField(
                labelText: 'Email',
                hintText: agent?.email ?? "",
                isPasswordTextField: false),
            textField(
                labelText: 'Password',
                hintText: '***********',
                isPasswordTextField: true),
          ],
        ),
      ),
    );
  }

  Widget agentProfile() {
    return Center(
        child: Stack(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: AppColors.white,
              ),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 10))
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                  ))),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return AlertDialog(
                      
                        backgroundColor: AppColors.blue,
                        content: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: AppColors.black,
                                  ),
                                  SizedBox(width: 10.w),
                                  EraText(
                                    text: 'Camera',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: AppColors.white,
                  ),
                  color: AppColors.blue,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    ));
  }

  Widget textField(
      {required String hintText,
      TextStyle? hintstlye,
      double? fontSize,
      Color? color,
      String? text,
      String? labelText,
      bool? isPasswordTextField}) {
    return Column(
      children: [
        EraText(
          text: text ?? '',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.hint,
          lineHeight: 1.0,
        ),
        TextField(
          enabled: false,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            suffixIcon: isPasswordTextField != null && isPasswordTextField
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            hintText: hintText,
            hintStyle: hintstlye ??
                TextStyle(color: AppColors.black, fontSize: fontSize ?? 18.sp),
          ),
        ),
      ],
    );
  }
}
