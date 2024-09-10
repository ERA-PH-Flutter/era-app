import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 150.h,
        child: _buildAppBarContent(),
      ),
      body: body,
    );
  }

  Widget _buildAppBarContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200.w,
            height: 200.h,
            color: AppColors.blue,
            child: Image.asset(AppEraAssets.eraPhLogo),
          ),
          Flexible(
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildAppBarIcons(),
                ),
                const Spacer(),
                _buildDashboardTitle(),
              ],
            ),
          ),
        ],
      );

  Widget _buildDashboardTitle() => Container(
        height: 45.h,
        width: Get.width,
        color: Colors.grey[350],
        child: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: EraText(
            text: 'Dashboard',
            color: AppColors.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  List<Widget> _buildAppBarIcons() => [
        Image.asset(AppEraAssets.notifAdmin, height: 50.h),
        Image.asset(AppEraAssets.helpAdmin, height: 50.h),
        Image.asset(AppEraAssets.mailAdmin, height: 50.h),
        Image.asset(AppEraAssets.profileAdmin, height: 80.h),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EraText(
                text: 'FirstName LastName',
                color: AppColors.white,
                fontSize: 12.sp,
              ),
              EraText(
                text: 'Status',
                color: AppColors.white,
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
      ];
}
