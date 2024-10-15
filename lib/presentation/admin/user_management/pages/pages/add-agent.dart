import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../repository/logs.dart';
import '../../../../../repository/user.dart';
import '../../../../global.dart';

class AddAgent extends GetView<AgentAdminController> {
  const AddAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            EraText(
              text:
                  '${controller.agentListingssss != null ? "EDIT" : "ADD"} AGENT',
              fontSize: EraTheme.header,
              color: AppColors.black,
            ),
            SizedBox(
              height: 10.h,
            ),
            buildTextFormField2('First Name *', controller.fNameA,
                'Last Name *', controller.lNameA),
            SizedBox(
              height: 10.h,
            ),
            buildTextFormField3(
                'Email Address *',
                controller.emailAdressA,
                'Date of Birth *',
                controller.dateBirthA,
                'Gender *',
                controller.sexA, onTap: () async {
              var date = await showDatePicker(
                  context: Get.context!,
                  firstDate: DateTime(1930),
                  lastDate: DateTime(2005),
                  currentDate: DateTime(2000));
              controller.dateBirthA.text =
                  DateFormat('MM dd, yyyy').format(date!);
            }),
            SizedBox(
              height: 10.h,
            ),
            buildTextFormField2(
              'Office Location *',
              controller.officeLA,
              'Licensed Number *',
              controller.licensedNumA,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: 'Phone Number *',
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          lineHeight: 0.5,
                        ),
                        sb10(),
                        SizedBox(
                          height: 125.h,
                          width: Get.width / 5.1 - 4.w,
                          child: TextformfieldWidget(
                            controller: controller.phoneNA,
                            fontSize: 18.sp,
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sbw25(),
                  SizedBox(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: controller.selectedAgentType,
                        Types: controller.agentType,
                        onChanged: (value) =>
                            controller.selectedAgentType.value,
                        name: 'Position *',
                        hintText: 'Select Position'),
                  ),
                  sbw25(),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: 'Password *',
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          lineHeight: 0.5,
                        ),
                        sb10(),
                        Container(
                          margin: EdgeInsets.only(bottom: 15.w),
                          height: 120.h,
                          width: Get.width / 5.1 - 4.w,
                          child: TextformfieldWidget(
                            controller: controller.passwordA,
                            fontSize: 12.sp,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Padding(
                    padding: EdgeInsets.only(top: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: 'Confirm Password *',
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          lineHeight: 0.5,
                        ),
                        sb10(),
                        Container(
                          margin: EdgeInsets.only(bottom: 15.w),
                          height: 120.h,
                          width: Get.width / 5.1 - 4.w,
                          child: TextformfieldWidget(
                            controller: controller.confirmPA,
                            fontSize: 18.sp,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildTextFieldFormDesc('Description *', controller.descriptionA),
            SizedBox(
              height: 10.h,
            ),
            // buildUploadPhoto(onTap: () async{
            //   controller.getImageGallery();
            // }),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  onTap: () async {
                    if (controller.agentListingssss == null) {
                      BaseController().showLoading();
                      try {
                        await Authentication().signup(
                            email: controller.emailAdressA.text,
                            password: controller.passwordA.text);
                        var id = await Authentication().login(
                            email: controller.emailAdressA.text,
                            password: controller.passwordA.text);
                        //var image = await CloudStorage().upload(file: controller.images, target: 'users/test/${controller.images.path.split('/')[controller.images.path.split('/').length - 1]}');
                        await EraUser(
                                id: id,
                                firstname: controller.fNameA.text,
                                lastname: controller.lNameA.text,
                                email: controller.emailAdressA.text,
                                birthday: controller.dateBirthA.text,
                                whatsApp: controller.phoneNA.text,
                                gender: controller.sexA.text,
                                location: controller.officeLA.text,
                                licence: controller.licensedNumA.text,
                                position: controller.selectedAgentType.value,
                                description: controller.descriptionA.text,
                                eraId:
                                    "ERA_agent${(settings!.agentCount! + 1).toString().padLeft(5, "0")}",
                                status: "approved")
                            .add();
                        await Logs(
                                title:
                                    "${user!.firstname} ${user!.lastname} added an agent with ID ERA_agent${(settings!.agentCount! + 1).toString().padLeft(5, "0")}",
                                type: "account")
                            .add();
                        settings!.agentCount = settings!.agentCount! + 1;
                        await settings!.update();
                        BaseController().showSuccessDialog(
                            title: "Add Agent Success",
                            description: "Agent added successfully!",
                            hitApi: () {
                              Get.back();
                              Get.back();
                            });
                      } catch (e) {
                        BaseController().showSuccessDialog(
                            title: "Error!",
                            description: "$e",
                            hitApi: () {
                              Get.back();
                              Get.back();
                            });
                      }
                    } else {
                      BaseController().showLoading();
                      BaseController().showSuccessDialog(
                          title: "Edit Agent Success",
                          description: "Agent edited successfully!",
                          hitApi: () {
                            Get.back();
                            Get.back();
                          });
                      try {
                        await controller.updateValues();
                      } catch (e) {
                        BaseController().showSuccessDialog(
                            title: "Error!",
                            description: "$e",
                            hitApi: () {
                              Get.back();
                              Get.back();
                            });
                      }
                    }
                  },
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  text: controller.agentListingssss == null ? 'SUBMIT' : "EDIT",
                  bgColor: AppColors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                Builder(
                  builder: (context) {
                    if (controller.agentListingssss == null) {
                      return Button(
                        onTap: () {
                          controller.clearfield();
                        },
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: 150.w,
                        text: 'CLEAR FIELDS',
                        bgColor: AppColors.hint,
                        borderRadius: BorderRadius.circular(30),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildTextFormField(
      Widget child, double width, String text, double height) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: height,
              width: width,
              child: child,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildTextFormField2(
      String text,
      TextEditingController controller,
      String text2,
      TextEditingController controller2,
      {void Function(String)? onChanged}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 2.5,
              child: TextformfieldWidget(
                controller: controller,
                fontSize: 18.sp,
                maxLines: 1,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text2,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 2.5,
              child: TextformfieldWidget(
                controller: controller2,
                fontSize: 18.sp,
                maxLines: 1,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildTextFormField3(
      String text,
      TextEditingController controller,
      String text2,
      TextEditingController controller2,
      String text3,
      TextEditingController controller3,
      {onTap}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 2.5,
              child: TextformfieldWidget(
                controller: controller,
                fontSize: 18.sp,
                maxLines: 1,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text2,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                onTap: onTap ?? () {},
                controller: controller2,
                fontSize: 18.sp,
                maxLines: 1,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text3,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                controller: controller3,
                fontSize: 18.sp,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildTextFormField4({
    String? text,
    TextEditingController? controller,
    String? text2,
    void Function(String)? onChanged,
    TextEditingController? controller2,
    String? text3,
    TextEditingController? controller3,
    String? text4,
    TextEditingController? controller4,
    TextInputType? keyboardType,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text!,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                controller: controller,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text2!,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                controller: controller2,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text3!,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                controller: controller3,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text4!,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 60.h,
              width: Get.width / 5.1 - 3.w,
              child: TextformfieldWidget(
                controller: controller4,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildTextFieldFormDesc(
      String text, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 200.h,
              width: Get.width / 1.2 - 45.w,
              child: TextformfieldWidget(
                controller: controller,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                fontSize: 12.sp,
                maxLines: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget buildUploadPhoto({text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: text ?? ' Upload Photo *',
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: Get.width,
            height: 250.h,
            decoration: BoxDecoration(
              color: AppColors.hint.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.hint.withOpacity(0.9),
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(AppEraAssets.uploadAdmin),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
