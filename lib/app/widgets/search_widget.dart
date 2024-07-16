import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.kRedColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {

              },
              icon: Icon(
                CupertinoIcons.search,
                color: AppColors.white,
                size: 30.sp,
              )),
          FarmerText(
            text: 'SEARCH',
            fontSize: 30.sp,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
