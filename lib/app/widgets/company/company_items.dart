import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyItems extends StatelessWidget {
  final CompanyModels companyItems;
  const CompanyItems({super.key, required this.companyItems});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          width: 420.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: companyItems.image,
                fit: BoxFit.cover,
                height: 250.h,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Spacer(),
            ],
          ),
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
          left: 30.w,
          right: 40.w,
          top: 210.h,
          child: Card(
            color: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: EraText(
                    text: companyItems.title,
                    fontSize: 16.sp,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: EraText(
                    text: companyItems.description,
                    fontSize: 16.sp,
                    color: Colors.black,
                    maxLines: 4,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                  text: 'READ MORE',
                  onTap: () {
                    Get.toNamed("/aboutus");
                  },
                  bgColor: AppColors.kRedColor,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(30.r),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
