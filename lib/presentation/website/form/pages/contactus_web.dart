import 'dart:io';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';

class ContactUsWeb extends GetView<FormWebController> {
  const ContactUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FormWebController());
    return Container(
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppEraAssets.bgWeb), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sb20(),
              EraText(
                text: "Contact Us",
                fontSize: EraTheme.headerWeb,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
              sb20(),

              EraText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non congue libero. Nullam eget odio nisl. In vitae nisi dapibus, mollis enim eget, efficitur est. Morbi euismod leo id nisl consectetur, nec vehicula nunc placerat. Phasellus dictum nibh eleifend sapien egestas, at elementum velit faucibus. Sed ullamcorper lectus ac sapien aliquam, non hendrerit eros ullamcorper. Nullam pharetra arcu tortor, sit amet ultrices magna molestie quis. Etiam pellentesque pretium justo, in rutrum nisl laoreet nec. Suspendisse dictum arcu non nisl interdum vehicula. In nec urna dignissim augue pharetra sagittis. Etiam dictum augue eget lacus euismod laoreet. Suspendisse nec ipsum auctor, venenatis nunc eu, interdum dui. Nullam ligula tortor, aliquam et mollis a, condimentum dictum neque. Nullam id odio at ex cursus efficitur quis vitae ipsum. In interdum odio non mauris scelerisque, vel tempus arcu sagittis. Etiam fermentum ex eget pellentesque efficitur.",
                fontSize: EraTheme.paragraphWeb - 10.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              sb20(),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: findUsWeb(),
                ),
                Expanded(flex: 1, child: contactsWeb()),
              ]),

              // Help.iconButton(
              //   padding: EdgeInsets.only(right: 10.w),
              //   icon: AppEraAssets.whatsappIcon,
              //   icon2: AppEraAssets.emailIcon,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactsWeb() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedWidgets.textFormfield(
          hintText: 'Full Name',
          controller: controller.nameC,
          keyboardType: TextInputType.text,
        ),
        // SharedWidgets.textFormfield(
        //   controller: controller.numberC,
        //   hintText: '000-000-0000',
        //   keyboardType: TextInputType.number,
        // ),
        SharedWidgets.textFormfield(
          controller: controller.emailAC,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),

        SharedWidgets.dropDown(
          controller.selectedSubj,
          controller.subject,
          (value) {
            controller.selectedSubj.value = value;
          },
          '',
          'Select Subject Type',
        ),
        // AddListings.dropDownAddlistings(
        //   selectedItem: controller.selectedSubj,
        //   Types: controller.subject,
        //   onChanged: (value) => controller.selectedSubj.value = value!,
        //   name: 'Subject Type',
        //   hintText: 'Select Subject Type',
        //   color: AppColors.black,
        //   padding: EdgeInsets.zero,
        // ),
        SharedWidgets.textFormfield(
          controller: controller.messageC,
          hintText: 'Type your message here',
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),

        sb30(),
        Button.button2(
          Get.width,
          53.h,
          () async {
            await controller.submitContact();
          },
          'Send',
        ),
        sb30(),
      ],
    );
  }

  Widget findUsWeb() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Visit ERA Philippines to learn more about this project.',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.only(
              left: 8.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppEraAssets.markerIcon,
                  width: 50.w,
                  height: 50.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                EraText(
                  text:
                      '1212 Century Spire Bldg. Century City,\nKalayaan Ave. Makati City',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(controller.whatsappUrl);
            },
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      AppEraAssets.whatsappIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: '+639177710572',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sb10(),
          GestureDetector(
            onTap: () {
              launchUrl(controller.emailUrl);
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      color: AppColors.kRedColor,
                      AppEraAssets.emailIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: 'sales@eraphilippines.com',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
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
