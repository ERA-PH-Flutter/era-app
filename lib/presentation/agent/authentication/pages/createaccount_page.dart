import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../app/constants/sized_box.dart';
import '../../listings/add-edit_listings/pages/addlistings.dart';
import '../controllers/authentication_controller.dart';

class CreateAccount extends GetView<LoginPageController> {
  const CreateAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kRedColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SharedWidgets.backgroundColumn(),
                SharedWidgets.paddingText('CREATE AN ACCOUNT', FontWeight.bold),
                Container(
                  height: Get.height - 100.h,
                  margin: EdgeInsets.only(top: 50.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 25.w, left: 25.w, top: 25.h, bottom: 25.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child: SharedWidgets.textFormfield(
                                  textInputType: TextInputType.text,
                                  labelText: 'First Name',
                                  controller: controller.firstName),
                            ),
                            SizedBox(width: 10.w),
                            Flexible(
                              child: SharedWidgets.textFormfield(
                                  textInputType: TextInputType.text,
                                  labelText: 'Last Name',
                                  controller: controller.lastName),
                            ),
                          ],
                        ),
                        sb20(),

                        //password
                        Obx(
                          () => TextFormField(
                            validator: (value) {
                              if (value == null) return null;
                              if (value.length < 10) {
                                return 'Use at least 10 characters';
                              }
                              return null;
                            },
                            controller: controller.passwordC,
                            obscureText: !controller.passwordVisible.value,
                            style: TextStyle(
                                color: AppColors.black, fontSize: 18.sp),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: AppColors.hint, fontSize: 18.sp),
                              filled: false,
                              suffixIcon: IconButton(
                                icon: Icon(controller.passwordVisible.value
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill),
                                onPressed: () {
                                  controller.passwordVisible.value =
                                      !controller.passwordVisible.value;
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.hint),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.hint),
                              ),
                            ),
                          ),
                        ),

                        SharedWidgets.textFormfield(
                          textInputType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          controller: controller.emailAd,
                          validator: (value) {
                            if (!RegExp(
                                    r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                                .hasMatch(value!)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        sb30(),

                        IntlPhoneField(
                          pickerDialogStyle: PickerDialogStyle(
                              backgroundColor: Colors.white, width: Get.width),
                          focusNode: FocusNode(),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.sp,
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
                          controller: controller.contactNo,
                          initialCountryCode: 'PH',
                          onChanged: (phone) {
                            controller.contactNo.text = phone.number;

                            controller.fullContactNo.value =
                                '${phone.countryCode}${phone.number}';
                          },
                        ),

                        sb30(),
                        Button(
                          margin: EdgeInsets.zero,
                          width: Get.width,
                          bgColor: AppColors.kRedColor,
                          text: 'CONTINUE',
                          fontSize: 18.sp,
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

                            if (controller.passwordC.text.isEmpty) {
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
                            if (controller.formKey.currentState!.validate()) {
                              Get.toNamed('/nextPage');
                            } else {
                              BaseController().showSuccessDialog(
                                okayButton: 'Close',
                                title: "Error",
                                description:
                                    "Please correct the errors in the form before continuing.",
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                        ),
                        sb20(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
    // SharedWidgets.textFormfield(
                        //   name: 'Age',
                        //   textInputType: TextInputType.number,
                        //   hintText: 'Age',
                        //   controller: controller.age,
                        // ),
                        // SizedBox(height: 20.h),
                        // SharedWidgets.dropDown(
                        //     controller.selectedGender,
                        //     controller.genderType,
                        //     (value) => controller.selectedGender.value = value!,
                        //     'Gender',
                        //     'Gender'),
                        // SizedBox(height: 30.h),