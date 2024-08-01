import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/home/controllers/home_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget{
  static build(searchFunction){
    return GestureDetector(
      onTap: searchFunction,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.kRedColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/searchIcon.png',
              height: 34.h,
              width: 33.w,
            ),
            EraText(
              text: 'SEARCH',
              fontSize: 25.sp,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}