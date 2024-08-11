
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
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Card(
            elevation: 0,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CachedNetworkImage(
                  imageUrl: companyItems.image,
                  fit: BoxFit.cover,
                  height: 240.h,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.asset(
                //   companyItems.image,
                //   fit: BoxFit.cover,
                //   height: 240.h,
                // ),
                Spacer(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 275,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      spreadRadius: 60,
                      blurRadius: 8,
                      offset: Offset(0, 8))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 15.w,
            right: 15.w,
            top: 205,
            child: Card(
              color: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EraText(
                        text: companyItems.title,
                        fontSize: 16.sp,
                        color: AppColors.kRedColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                      borderRadius: BorderRadius.circular(30),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
