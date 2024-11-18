import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/website/authentication/controller/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../app/constants/assets.dart';
import '../../../app/constants/colors.dart';
import '../../../app/constants/sized_box.dart';
import '../../../app/widgets/app_text.dart';
import '../../../app/widgets/createaccount_widget.dart';

class CreateAccountWeb extends GetView<AuthenticationController> {
  const CreateAccountWeb({super.key});

  @override
  Widget build(BuildContext context) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppEraAssets.bgWeb),
                      fit: BoxFit.cover)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EraText(
                      text: 'Create Account',
                      color: AppColors.kRedColor,
                      fontSize: EraTheme.subHeaderWeb,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SharedWidgets.textFormfield(
                            controller: controller.firstName,
                            hintText: 'First Name',
                          ),
                        ),
                        sbw20(),
                        Expanded(
                          child: SharedWidgets.textFormfield(
                            controller: controller.lastName,
                            hintText: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SharedWidgets.textFormfield(
                            controller: controller.age,
                            hintText: 'Age',
                          ),
                        ),
                        sbw20(),
                        Expanded(
                          child: SharedWidgets.textFormfield(
                            controller: controller.email,
                            hintText: 'Gender',
                          ),
                        ),
                      ],
                    ),
                    sb20(),
                    IntlPhoneField(
                      pickerDialogStyle: PickerDialogStyle(
                          backgroundColor: Colors.white, width: Get.width),
                      focusNode: FocusNode(),
                      style: TextStyle(
                        color: AppColors.hint,
                        background: Paint()..color = AppColors.white,
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColors.white,
                        filled: true,
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      //    controller: controller.contactNo,
                      initialCountryCode: 'PH',
                      onChanged: (phone) {
                        //     controller.contactNo.text = phone.number;

                        //    controller.fullContactNo.value =
                        '${phone.countryCode}${phone.number}';
                      },
                    ),

                    //         TextFormField(
                    //   //maxLines: maxLines,
                    //   //controller: controller,
                    //   decoration: InputDecoration(
                    //     hintText: 'Password',
                    //     hintStyle: TextStyle(color: AppColors.hint, fontSize: 18.sp),
                    //     labelStyle: TextStyle(color: AppColors.hint),
                    //     filled: false,
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: AppColors.hint),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //       borderSide: BorderSide(color: AppColors.hint),
                    //     ),
                    //   ),
                    //   keyboardType:  TextInputType.none,
                    //   // textInputAction: TextInputAction.newline,
                    // ),
                    // Obx(
                    //   () => SizedBox(
                    //     width: 10.w,
                    //     child: TextFormField(
                    //       controller: pass,
                    //       obscureText: isPasswordNotVisible.value,
                    //       style: TextStyle(color: AppColors.black, fontSize: 15.sp),
                    //       decoration: InputDecoration(
                    //         hintText: 'Password',
                    //         hintStyle: TextStyle(color: AppColors.hint),
                    //         fillColor: AppColors.white,
                    //         filled: true,
                    //         suffixIcon: IconButton(
                    //           icon: Icon(isPasswordNotVisible.value
                    //               ? CupertinoIcons.eye_fill
                    //               : CupertinoIcons.eye_slash_fill),
                    //           onPressed: () {
                    //             isPasswordNotVisible.value =
                    //                 !isPasswordNotVisible.value;
                    //           },
                    //         ),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //           borderSide: BorderSide(
                    //             color: AppColors.black,
                    //             width: 1,
                    //           ),
                    //         ),
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });

    return Container();
  }
}
