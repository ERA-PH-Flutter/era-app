// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/company/company_items.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyGridPage extends StatelessWidget {
  final List companymodels;
  const CompanyGridPage({
    super.key,
    required this.companymodels,
  });

  @override
  Widget build(BuildContext context) {
    return companymodels.isNotEmpty
        ? SizedBox(
            height: 460.h,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidth - 10.w),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 430.w, //410
              ),
              itemCount: companymodels.length,
              itemBuilder: (context, i) => Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CloudStorage().imageLoader(
                        ref: companymodels[i].image,
                        height: 250.h,
                      ),
                      Spacer(),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 270.h,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              spreadRadius: 60.w,
                              blurRadius: 8.w,
                              offset: Offset(0, 8.h))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20.w,
                    right: 30.w,
                    top: 195.h,
                    child: Card(
                      color: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidthSmall,
                            vertical: 10.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EraText(
                              text: companymodels[i].title,
                              fontSize: EraTheme.paragraph + 4.sp,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            EraText(
                              text: companymodels[i].description,
                              fontSize: EraTheme.paragraph,
                              color: Colors.black,
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            Button(
                              text: 'READ MORE',
                              onTap: () {
                                Get.to(
                                  () => CompanyNewsPage(
                                    companymodelss:
                                        CompanyModels.companyNewsModels[
                                            i], // Pass the selected item
                                  ),
                                );
                              },
                              bgColor: AppColors.kRedColor,
                              height: 30.h,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 120.h,
            child: Center(
              child: EraText(
                text: 'No featured news!',
                color: Colors.black,
                fontSize: EraTheme.subHeader,
              ),
            ),
          );
  }
}
