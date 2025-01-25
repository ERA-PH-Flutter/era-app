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

class SellPropertyWeb extends GetView<FormWebController> {
  const SellPropertyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    //  Get.put(FormWebController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: SingleChildScrollView(
        child: SizedBox(
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
                        colors: [
                          AppColors.kRedColor,
                          AppColors.kRedColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
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
                            Column(
                              children: [
                                SharedWidgets.textFormfield(
                                    textInputType: TextInputType.emailAddress,
                                    hintText: 'Email Address',
                                    controller: controller.emailAd),
                                sb10(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SharedWidgets.textFormfield(
                                          textInputType: TextInputType.text,
                                          hintText: 'Name',
                                          controller: controller.name),
                                    ),
                                    sbw20(),
                                    Expanded(
                                      flex: 1,
                                      child: SharedWidgets.textFormfield(
                                          textInputType: TextInputType.number,
                                          hintText: 'Phone Number',
                                          controller: controller.phoneNum),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SharedWidgets.textFormfield(
                                          textInputType:
                                              TextInputType.streetAddress,
                                          hintText: 'Property Location',
                                          controller: controller.propertyLoc),
                                    ),
                                    sbw20(),
                                    sb20(),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 28.h),
                                          child: SharedWidgets.dropDownListings(
                                              selectedItem:
                                                  controller.selectedProperty,
                                              Types: controller.propertyTypes,
                                              onChanged: (value) {
                                                controller.selectedProperty
                                                    .value = value;
                                              },
                                              hintText: "Property Type"),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: SharedWidgets.textFormfield(
                                            onChanged: (value) {
                                              value = value.replaceAll(',', '');
                                              if (value.isNotEmpty) {
                                                final formattedValue =
                                                    value.replaceAllMapped(
                                                        RegExp(
                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                        (Match m) =>
                                                            '${m[1]},');
                                                controller.price.value =
                                                    TextEditingValue(
                                                  text: formattedValue,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: formattedValue
                                                              .length),
                                                );
                                              }
                                            },
                                            textInputType: TextInputType.number,
                                            hintText: 'Price',
                                            controller: controller.price),
                                      ),
                                    ),
                                  ],
                                ),
                                SharedWidgets.textFormfield(
                                  textInputType: TextInputType.multiline,
                                  hintText: 'Description',
                                  controller: controller.message,
                                  MaxLines: 10,
                                ),
                                sb20(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Button(
                                      alignment: Alignment.centerLeft,
                                      onTap: () {
                                        controller.submitSellProperty();
                                      },
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: 250.w,
                                      text: 'S E N D',
                                      fontSize: EraTheme.buttonText,
                                      bgColor: AppColors.kRedColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ],
                                ),
                                sb50(),
                                //             AboutUsWeb.buildJoinUsSection(),
                              ],
                            )
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal:
                            //           EraTheme.paddingWidthXSmall - 10.w),
                            //   child: Column(
                            //     children: [
                            //       SharedWidgets.textFormfield(
                            //           keyboardType: TextInputType.text,
                            //           hintText: 'Name',
                            //           controller: controller.phoneNum),
                            //       sb30(),
                            //       Row(
                            //         children: [
                            //           SizedBox(
                            //             width: Get.width / 2.3 + 10.w,
                            //             child: SharedWidgets.textFormfield(
                            //                 keyboardType: TextInputType.text,
                            //                 hintText: 'Email',
                            //                 controller: controller.emailAd),
                            //           ),
                            //           sbw30(),
                            //           SizedBox(
                            //             width: Get.width / 2.3 + 10.w,
                            //             child: SharedWidgets.textFormfield(
                            //                 keyboardType: TextInputType.text,
                            //                 hintText: 'Name',
                            //                 controller: controller.name),
                            //           ),
                            //         ],
                            //       ),
                            //       sb50(),
                            //       //contentpadding todo
                            //       TextformfieldWidget(
                            //         keyboardType: TextInputType.multiline,
                            //         textInputAction: TextInputAction.newline,
                            //         hintText: 'Enter Description',
                            //         hintstlye: TextStyle(),
                            //         maxLines: 13,
                            //         color: AppColors.hint,
                            //         enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //           borderSide:
                            //               BorderSide(color: AppColors.hint),
                            //         ),
                            //       ),
                            //       sb50(),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: [
                            //           Button(
                            //             alignment: Alignment.centerLeft,
                            //             onTap: () async {},
                            //             margin:
                            //                 EdgeInsets.symmetric(horizontal: 5),
                            //             width: 250.w,
                            //             text: 'S E N D',
                            //             fontSize: EraTheme.buttonText,
                            //             bgColor: AppColors.kRedColor,
                            //             borderRadius: BorderRadius.circular(30),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  sb50(),
                ],
              ),
              Positioned(
                top: 10.h,
                right: 0,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                  fit: BoxFit.contain,
                  height: Get.height - 450.h,
                ),
              ),
            ],
          ),
        ),
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
