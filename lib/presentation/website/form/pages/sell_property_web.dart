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

class SellPropertyWeb extends GetResponsiveView<FormWebController> {
  SellPropertyWeb({super.key});

  _buildTitle(text,
      {fontWeight, fontSize, color, EdgeInsetsGeometry? padding}) {
    return Container(
      width: Get.width,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
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
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize:
            fontSize ?? Theme.of(Get.context!).textTheme.bodyMedium?.fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.hint,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDesktop(width, height) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                  height: height,
                  width: screen.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sb30(),
                            _buildTitle('Sell Your Property',
                                fontSize: Theme.of(Get.context!)
                                    .textTheme
                                    .headlineLarge
                                    ?.fontSize,
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
                      width: width,
                      height: height,
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
                      width: width * 2,
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
                                    flex: 1,
                                    child: SharedWidgets.textFormfield(
                                        textInputType:
                                            TextInputType.streetAddress,
                                        hintText: 'Property Location',
                                        controller: controller.propertyLoc),
                                  ),
                                  sbw20(),
                                  //sb20(),
                                  Expanded(
                                    flex: 1,
                                    child: SharedWidgets.textFormfield(
                                        onChanged: (value) {
                                          value = value.replaceAll(',', '');
                                          if (value.isNotEmpty) {
                                            final formattedValue =
                                                value.replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => '${m[1]},');
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
                                ],
                              ),
                              sb30(),
                              SharedWidgets.dropDownListings(
                                  selectedItem: controller.selectedProperty,
                                  Types: controller.propertyTypes,
                                  onChanged: (value) {
                                    controller.selectedProperty.value = value;
                                  },
                                  hintText: "Property Type"),
                              SharedWidgets.textFormfield(
                                textInputType: TextInputType.multiline,
                                hintText: 'Description',
                                controller: controller.message,
                                MaxLines: 10,
                              ),
                              sb20(),
                              Button(
                                width: Get.width,
                                height: 65.h,

                                fontWeight: FontWeight.w500,

                                onTap: () {
                                  controller.submitSellProperty();
                                },
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                // width: 250.w,
                                text: 'S E N D',
                                fontSize: Theme.of(Get.context!)
                                    .textTheme
                                    .titleMedium
                                    ?.fontSize,
                                bgColor: AppColors.kRedColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              sb50(),
                              //             AboutUsWeb.buildJoinUsSection(),
                            ],
                          )
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
              left: 0,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                fit: BoxFit.contain,
                width: Get.width,
                height: Get.height * 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTablet(width, height) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 2),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.network(
                //   'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                //   fit: BoxFit.contain,
                //   width: Get.width,
                //   height: Get.height * 0.6,
                // ),

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
                  height: height,
                  width: screen.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sb30(),
                            _buildTitle('Sell Your Property',
                                fontSize: Theme.of(Get.context!)
                                    .textTheme
                                    .headlineLarge
                                    ?.fontSize,
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
                _buildTitle('Share your property details',
                    padding: EdgeInsets.zero,
                    fontSize: Theme.of(Get.context!)
                        .textTheme
                        .headlineLarge
                        ?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor),
                // EraText(
                //   text: 'Share your property details',
                //   color: AppColors.blue,
                //   fontSize: EraTheme.headerWeb,
                //   fontWeight: FontWeight.bold,
                // ),
                sb30(),
                Container(
                  alignment: Alignment.centerLeft,
                  width: width * 2,
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
                                flex: 1,
                                child: SharedWidgets.textFormfield(
                                    textInputType: TextInputType.streetAddress,
                                    hintText: 'Property Location',
                                    controller: controller.propertyLoc),
                              ),
                              sbw20(),
                              //sb20(),
                              Expanded(
                                flex: 1,
                                child: SharedWidgets.textFormfield(
                                    onChanged: (value) {
                                      value = value.replaceAll(',', '');
                                      if (value.isNotEmpty) {
                                        final formattedValue =
                                            value.replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (Match m) => '${m[1]},');
                                        controller.price.value =
                                            TextEditingValue(
                                          text: formattedValue,
                                          selection: TextSelection.collapsed(
                                              offset: formattedValue.length),
                                        );
                                      }
                                    },
                                    textInputType: TextInputType.number,
                                    hintText: 'Price',
                                    controller: controller.price),
                              ),
                            ],
                          ),
                          sb30(),
                          SharedWidgets.dropDownListings(
                              selectedItem: controller.selectedProperty,
                              Types: controller.propertyTypes,
                              onChanged: (value) {
                                controller.selectedProperty.value = value;
                              },
                              hintText: "Property Type"),
                          SharedWidgets.textFormfield(
                            textInputType: TextInputType.multiline,
                            hintText: 'Description',
                            controller: controller.message,
                            MaxLines: 10,
                          ),
                          sb20(),
                          Button(
                            width: Get.width,
                            height: 65.h,

                            fontWeight: FontWeight.w500,

                            onTap: () {
                              controller.submitSellProperty();
                            },
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            // width: 250.w,
                            text: 'S E N D',
                            fontSize: Theme.of(Get.context!)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            bgColor: AppColors.kRedColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          sb50(),
                          //             AboutUsWeb.buildJoinUsSection(),
                        ],
                      )
                    ],
                  ),
                ),
                sb50(),
              ],
            ),
            Positioned(
              top: 20.h,
              right: 0,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                fit: BoxFit.contain,
                //    width: Get.width,
                height: Get.height - 450.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() => SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sb30(),
              _buildTitle('Share your property details',
                  fontSize:
                      Theme.of(Get.context!).textTheme.headlineLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kRedColor),
              sb30(),
              SharedWidgets.textFormfield(
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email Address',
                  controller: controller.emailAd),
              sb10(),
              SharedWidgets.textFormfield(
                  textInputType: TextInputType.text,
                  hintText: 'Name',
                  controller: controller.name),
              sb10(),
              SharedWidgets.textFormfield(
                  textInputType: TextInputType.number,
                  hintText: 'Phone Number',
                  controller: controller.phoneNum),
              sb10(),
              SharedWidgets.textFormfield(
                  textInputType: TextInputType.streetAddress,
                  hintText: 'Property Location',
                  controller: controller.propertyLoc),
              sb10(),
              SharedWidgets.textFormfield(
                  textInputType: TextInputType.number,
                  hintText: 'Price',
                  controller: controller.price),
              sb20(),
              SharedWidgets.dropDownListings(
                  selectedItem: controller.selectedProperty,
                  Types: controller.propertyTypes,
                  onChanged: (value) {
                    controller.selectedProperty.value = value;
                  },
                  hintText: "Property Type"),
              sb10(),
              SharedWidgets.textFormfield(
                textInputType: TextInputType.multiline,
                hintText: 'Description',
                controller: controller.message,
                MaxLines: 10,
              ),
              sb20(),
              Button(
                width: Get.width,
                height: 65.h,
                fontWeight: FontWeight.w500,
                onTap: () {
                  controller.submitSellProperty();
                },
                text: 'S E N D',
                fontSize: Theme.of(Get.context!).textTheme.titleSmall?.fontSize,
                bgColor: AppColors.kRedColor,
                borderRadius: BorderRadius.circular(30),
              ),
              sb30(),
            ],
          ),
        ),
      );

  @override
  Widget tablet() =>
      Center(child: _buildTablet(Get.width * 0.6, Get.height * 0.5));

  @override
  Widget desktop() => Center(
      //color: Colors.red,
      child: _buildDesktop(Get.width * 0.4, Get.height * 0.5));
}
