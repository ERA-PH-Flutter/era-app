import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';

class SellPropertyWeb extends StatelessWidget {
  const SellPropertyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                sb50(),
                Container(
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [
                        Color(0xFFC50000),
                        Color(0xFF8C0909)
                      ])),
                  height: Get.height - 400.h,
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
                                'Unlock the potential of your property with our expert guidance. Whether you’re selling a home, land, or commercial space, trust us to navigate the process smoothly.'),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildDescription(
                                color: AppColors.white,
                                'Discover personalized service, strategic marketing, and a dedicated team committed to achieving the best results for you. Let’s make selling your property a seamless experience'),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
                sb80(),
                Image.asset(
                  AppEraAssets.eraPh,
                  fit: BoxFit.cover,
                  height: 250.h,
                  width: 250.w,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10.h,
            right: 100.w,
            left: Get.width * 0.5,
            child: CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
              fit: BoxFit.cover,
              height: Get.height - 330.h,
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
