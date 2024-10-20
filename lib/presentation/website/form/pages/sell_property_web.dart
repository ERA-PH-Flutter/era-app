import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/button.dart';
import '../../../../app/widgets/createaccount_widget.dart';
import '../../../../app/widgets/textformfield_widget.dart';

class SellPropertyWeb extends GetView<FormWebController> {
  const SellPropertyWeb({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    Get.put(FormWebController());
    return Container(
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              sb50(),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFC50000), Color(0xFF8C0909)])),
                height: Get.height - 500.h,
                width: Get.width - 200.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sb30(),
                          _buildTitle('Sell Your Property',
                              fontSize: EraTheme.headerWeb + 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                          _buildDescription(
                              color: AppColors.white,
                              'Unlock the potential of your property with our expert guidance...'),
                          SizedBox(height: 20.h),
                          _buildDescription(
                              color: AppColors.white,
                              'Discover personalized service, strategic marketing...'),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ),
              sb80(),
              Column(
                children: [
                  Image.asset(
                    AppEraAssets.eraPh,
                    fit: BoxFit.cover,
                    width: 250.w,
                  ),
                  EraText(
                    text: 'Share your property details',
                    color: AppColors.blue,
                    fontSize: EraTheme.headerWeb,
                    fontWeight: FontWeight.bold,
                  ),
                  sb30(),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: Get.width - 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: 'Are you looking to sell your property?',
                          color: AppColors.hint,
                          fontSize: EraTheme.text15 + 3.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        sb10(),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Obx(() => Checkbox(
                                    value: controller.isCheckedYes.value,
                                    onChanged: (value) {
                                      controller.isCheckedYes.value =
                                          !controller.isCheckedYes.value;
                                    },
                                  )),
                            ),
                            sbw10(),
                            Expanded(
                              child: EraText(
                                text: 'YES',
                                color: AppColors.hint,
                                fontSize: EraTheme.text15 + 3.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Obx(() => Checkbox(
                                    value: controller.isCheckedNotNow.value,
                                    onChanged: (value) {
                                      controller.isCheckedNotNow.value =
                                          !controller.isCheckedNotNow.value;
                                    },
                                  )),
                            ),
                            sbw10(),
                            Expanded(
                              child: EraText(
                                text: 'NOT NOW',
                                color: AppColors.hint,
                                fontSize: EraTheme.text15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        sb20(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: EraTheme.paddingWidthXSmall - 10.w),
                          child: Column(
                            children: [
                              SharedWidgets.textFormfield(
                                  textInputType: TextInputType.text,
                                  hintText: 'Name',
                                  controller: controller.phoneNum),
                              sb30(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 2.3 + 10.w,
                                    child: SharedWidgets.textFormfield(
                                        textInputType: TextInputType.text,
                                        hintText: 'Email',
                                        controller: controller.emailAd),
                                  ),
                                  sbw30(),
                                  SizedBox(
                                    width: Get.width / 2.3 + 10.w,
                                    child: SharedWidgets.textFormfield(
                                        textInputType: TextInputType.text,
                                        hintText: 'Name',
                                        controller: controller.name),
                                  ),
                                ],
                              ),
                              sb50(),
                              TextformfieldWidget(
                                hintText: 'Enter Description',
                                maxLines: 13,
                                color: AppColors.hint,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColors.hint),
                                ),
                              ),
                              sb50(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Button(
                                    alignment: Alignment.centerLeft,
                                    onTap: () async {},
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: 250.w,
                                    text: 'S E N D',
                                    fontSize: EraTheme.buttonText,
                                    bgColor: AppColors.kRedColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10.h,
            right: 100.w,
            left: Get.width * 0.5,
            child: CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
              fit: BoxFit.cover,
              height: Get.height - 450.h, // Reduce this value to avoid overlap
              width: Get.width,
            ),
          ),
        ],
      ),
    );
  }

  _buildTitle(text, {fontWeight, fontSize, color}) {
    return Container(
      width: Get.width - 200.w,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb - 10.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? AppColors.black,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return Container(
      width: Get.width - 200.w,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb - 15.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.hint,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }
}
