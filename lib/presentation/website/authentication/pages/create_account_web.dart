import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/website/authentication/controller/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../app/widgets/button.dart';
import '../../../../app/widgets/createaccount_widget.dart';

import '../../../agent/utility/controller/base_controller.dart';

createAccountWeb({
  required AuthenticationWebController controller,
}) {
  showDialog(
      context: Get.context!,
      builder: (context) {
        var formKey = GlobalKey<FormState>();
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.symmetric(
            horizontal: EraTheme.paddingWidthAdmin * 6,
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppEraAssets.bgWeb),
                      fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.clear))),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: EraTheme.paddingWidthAdmin * 3),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            sb70(),
                            EraText(
                              text: 'CREATE ACCOUNT',
                              color: AppColors.kRedColor,
                              fontSize: EraTheme.subHeaderWeb,
                              fontWeight: FontWeight.bold,
                            ),
                            signInWidget(),
                            sb10(),
                            EraText(
                              text: 'Already have an account? Sign in here',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SharedWidgets.textFormfield(
                                      controller: controller.firstName,
                                      labelText: 'First Name'),
                                ),
                                sbw20(),
                                Expanded(
                                  flex: 1,
                                  child: SharedWidgets.textFormfield(
                                      controller: controller.lastName,
                                      labelText: 'Last Name'),
                                ),
                              ],
                            ),
                            sb20(),
                            IntlPhoneField(
                              pickerDialogStyle:
                                  PickerDialogStyle(width: Get.width),
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
                              keyboardType: TextInputType.number,
                              //    controller: controller.contactNo,
                              initialCountryCode: 'PH',
                              onChanged: (phone) {
                                //     controller.contactNo.text = phone.number;

                                //    controller.fullContactNo.value =
                                '${phone.countryCode}${phone.number}';
                              },
                            ),
                            sb20(),
                            Obx(
                              () => TextFormField(
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return 'Use at least 10 characters';
                                  }
                                },
                                obscureText: !controller.passwordVisible.value,
                                controller: controller.password,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.passwordVisible.value =
                                            !controller.passwordVisible.value;
                                      },
                                      icon: Icon(
                                          controller.passwordVisible.value
                                              ? CupertinoIcons.eye_fill
                                              : CupertinoIcons.eye_slash_fill)),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: AppColors.hint, fontSize: 18.sp),
                                  filled: false,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: AppColors.hint),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: AppColors.hint),
                                  ),
                                ),
                                keyboardType: TextInputType.none,
                                // textInputAction: TextInputAction.newline,
                              ),
                            ),
                            sbw20(),
                            SharedWidgets.textFormfield(
                                validator: (value) {
                                  if (!RegExp(
                                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                                      .hasMatch(value!)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                                labelText: 'Email Address',
                                controller: controller.emailAd),
                            sb50(),
                            Button(
                              margin: EdgeInsets.zero,
                              width: Get.width,
                              bgColor: AppColors.kRedColor,
                              text: 'CONTINUE',
                              fontSize: EraTheme.paragraphWeb,
                              fontWeight: FontWeight.w600,
                              onTap: () {
                                if (controller.firstName.text.isEmpty) {
                                  AddListings.showErroDialogs(
                                    title: "Error",
                                    description: "All fields are required!",
                                  );
                                  return;
                                }

                                if (controller.lastName.text.isEmpty) {
                                  AddListings.showErroDialogs(
                                    title: "Error",
                                    description: "All fields are required!",
                                  );
                                  return;
                                }

                                if (controller.password.text.isEmpty) {
                                  AddListings.showErroDialogs(
                                    title: "Error",
                                    description: "All fields are required!",
                                  );
                                  return;
                                }

                                if (controller.emailAd.text.isEmpty) {
                                  AddListings.showErroDialogs(
                                    title: "Error",
                                    description: "All fields are required!",
                                  );
                                  return;
                                }
                                if (formKey.currentState!.validate()) {
                                  createAccountNextPage(controller: controller);
                                } else {
                                  BaseController().showSuccessDialog(
                                      okayButton: 'Close',
                                      title: 'Error',
                                      description:
                                          'Please correct the errors in the form before continuing.');
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                            ),
                            sb50(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void createAccountNextPage({required AuthenticationWebController controller}) {
  showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidthAdmin * 6,
              vertical: EraTheme.paddingWidthAdmin - 20.h),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppEraAssets.bgWeb), fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: EraTheme.paddingWidth30,
                      top: EraTheme.paddingWidth20),
                  width: Get.width,
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthAdmin * 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sb30(),
                      EraText(
                        text: 'You\'re almost there!',
                        color: AppColors.kRedColor,
                        fontSize: EraTheme.subHeaderWeb,
                        fontWeight: FontWeight.bold,
                      ),
                      sb30(),
                      SharedWidgets.dropDownListings(
                        selectedItem: controller.selectedStatus,
                        Types: controller.statusType,
                        onChanged: (value) =>
                            controller.selectedStatus.value = value!,
                        hintText: 'What is your Status',
                      ),
                      sb20(),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SharedWidgets.textFormfield(
                                name: 'N/A if not applicable',
                                textInputType: TextInputType.text,
                                labelText: 'Who is your Recruiter? ',
                                controller: controller.recruiter),
                          ),
                          sbw10(),
                          Expanded(
                            flex: 1,
                            child: SharedWidgets.textFormfield(
                                textInputType: TextInputType.number,
                                labelText: 'Years of Experience',
                                controller: controller.experience),
                          ),
                        ],
                      ),
                      sb30(),
                      SharedWidgets.dropDownListings(
                        selectedItem: controller.selectedEducation,
                        Types: controller.educationType,
                        onChanged: (value) =>
                            controller.selectedEducation.value = value!,
                        hintText: 'Highest Education Level',
                      ),
                      sb30(),
                      SharedWidgets.dropDownListings(
                        selectedItem: controller.selectedTransaction,
                        Types: controller.transaction,
                        onChanged: (value) =>
                            controller.selectedTransaction.value = value!,
                        hintText: 'Total Number of Transaction',
                      ),
                      sb30(),
                      SharedWidgets.dropDownListings(
                        selectedItem: controller.selectedTransaction5years,
                        Types: controller.transaction,
                        onChanged: (value) =>
                            controller.selectedTransaction5years.value = value!,
                        hintText:
                            'Total Number of Transaction in the Past 5 years',
                      ),
                      sb30(),
                      SharedWidgets.dropDownListings(
                        selectedItem: controller.selectedSpeciality,
                        Types: controller.specialityType,
                        onChanged: (value) =>
                            controller.selectedSpeciality.value = value!,
                        hintText: 'Specialization',
                      ),
                      sb30(),
                      Button(
                        margin: EdgeInsets.zero,
                        width: Get.width,
                        bgColor: AppColors.kRedColor,
                        text: 'CREATE',
                        fontSize: EraTheme.paragraphWeb,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                         
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.emailAd.value.text.isEmpty ||
                                controller.password.value.text.isEmpty ||
                                controller.lastName.text.isEmpty ||
                                controller.firstName.text.isEmpty) {
                              AddListings.showErroDialogs(
                                title: "Error",
                                description:
                                    "All fields are required! Only Description is optional",
                              );
                              return;
                            }

                            controller.signUp();
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                      ),
                      sb50(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget signInWidget() {
  return RichText(
    text: TextSpan(
      text: 'Already have an account?',
      style: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.lato(fontWeight: FontWeight.w500).fontFamily,
      ),
      children: [
        TextSpan(
            text: ' Sign in here',
            style: TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.bold,
              fontFamily:
                  GoogleFonts.lato(fontWeight: FontWeight.w500).fontFamily,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Get.back();
              }),
      ],
    ),
  );
}
