import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin - 5.w),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: textFormfield(
                            controller: controller.fNameA,
                            hintText: 'First Name *',
                            textInputType: TextInputType.text),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        child: textFormfield(
                            controller: controller.lNameA,
                            hintText: 'Last Name *',
                            textInputType: TextInputType.text),
                      ),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      flex: 2,
                      child: textFormfield(
                          controller: controller.phoneNA,
                          hintText: 'PhoneNumber *',
                          textInputType: TextInputType.number),
                    ),
                  ],
                ),
                sb20(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: textFormfield(
                          controller: controller.emailAdressA,
                          hintText: 'Email Address *',
                          textInputType: TextInputType.text),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: textFormfield(
                          hintText: 'Age *',
                          textInputType: TextInputType.number,
                          controller: controller.age,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w),
                        child: dropDownListings(
                          selectedItem: controller.selectedGender,
                          Types: controller.agentGender,
                          onChanged: (value) =>
                              controller.selectedGender.value = value!,
                          hintText: 'Gender *',
                        ),
                      ),
                    ),
                  ],
                ),
                sb20(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: dropDownListings(
                        selectedItem: controller.selectedAgentType,
                        Types: controller.agentType,
                        onChanged: (value) =>
                            controller.selectedAgentType.value = value!,
                        hintText: 'Agent Type *',
                      ),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      flex: 1,
                      child: dropDownListings(
                        selectedItem: controller.selectedAgentRole,
                        Types: controller.agentRole,
                        onChanged: (value) =>
                            controller.selectedAgentRole.value = value!,
                        hintText: 'Agent Role *',
                      ),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      child: textFormfield(
                          controller: controller.passwordA,
                          hintText: 'Password *',
                          textInputType: TextInputType.text),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      child: textFormfield(
                          controller: controller.confirmPA,
                          hintText: 'Confirm Password *',
                          textInputType: TextInputType.text),
                    ),
                  ],
                ),
                sb20(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: textFormfield(
                          controller: controller.officeLA,
                          hintText: 'Office Location *',
                          textInputType: TextInputType.text),
                    ),
                    sb20(),
                    sbw20(),
                    Expanded(
                      child: textFormfield(
                          controller: controller.licensedNumA,
                          hintText: 'Licensed Number *',
                          textInputType: TextInputType.text),
                    ),
                  ],
                ),
                sb20(),

                textFormfield(
                    controller: controller.descriptionA,
                    hintText: 'Description *',
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    MaxLines: 10),

                SizedBox(
                  height: 10.h,
                ),
                // buildUploadPhoto(onTap: () async{
                //   controller.getImageGallery();
                // }),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                                    //birthday: controller.dateBirthA.text,
                                    whatsApp: controller.phoneNA.text,
                                    //gender: controller.sexA.text,
                                    location: controller.officeLA.text,
                                    licence: controller.licensedNumA.text,
                                    position:
                                        controller.selectedAgentType.value,
                                    description: controller.descriptionA.text,
                                    role: controller.selectedAgentRole.value,
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
                                title: "Submitted",
                                description: "Account created",
                                okayButton: 'Close',
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
                              title: "Submitted",
                              description: "Agent updated successfully!",
                              okayButton: 'Close',
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
                      text: controller.agentListingssss == null
                          ? 'SUBMIT'
                          : "EDIT",
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
            )));
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
    String? text5,
    TextEditingController? controller5,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: text!,
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              TextformfieldWidget(
                controller: controller,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: text2!,
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              TextformfieldWidget(
                controller: controller2,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ],
          ),
        ),
        sbw20(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: text5!,
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              TextformfieldWidget(
                controller: controller5,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: text3!,
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              TextformfieldWidget(
                controller: controller3,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: text4!,
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              TextformfieldWidget(
                controller: controller4,
                fontSize: 18.sp,
                maxLines: 1,
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ],
          ),
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

  static Widget dropDownListings(
      {RxnString? selectedItem,
      List<String>? Types,
      Function(String?)? onChanged,
      String? hintText}) {
    return Obx(
      () => DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.hint),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.hint),
          ),
        ),
        dropdownColor: AppColors.white,
        focusColor: AppColors.hint,
        value: selectedItem?.value,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        isExpanded: true,
        isDense: true,
        hint: Align(
          alignment: Alignment.centerLeft,
          child: EraText(
            text: hintText!,
            textAlign: TextAlign.center,
            color: Colors.grey,
            fontSize: 20.sp,
          ),
        ),
        items: Types!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: EraText(
              text: value,
              color: AppColors.black,
              fontSize: 20.sp,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget textFormfield({
    String? hintText,
    TextInputType? textInputType,
    String? name,
    TextEditingController? controller,
    int? MaxLines,
    onTap,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      maxLines: MaxLines ?? 1,
      controller: controller,
      textInputAction: textInputAction ?? TextInputAction.none,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hint, fontSize: 18.sp),
        labelStyle: TextStyle(color: AppColors.hint),
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.hint),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.hint),
        ),
      ),
      keyboardType: textInputType ?? TextInputType.none,
    );
  }
}
