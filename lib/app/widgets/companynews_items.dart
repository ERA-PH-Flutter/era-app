import 'dart:ui';

import 'package:architecture/app/constants/colors.dart';
import 'package:architecture/app/models/company_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyNewsItems extends StatelessWidget {
  final CompanyNewsModel companynewsitems;
  const CompanyNewsItems({super.key, required this.companynewsitems});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                companynewsitems.image,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ], color: AppColors.black),
                ),
              ),
            ],
          ),

          // SizedBox(
          //   height: 15.h,
          // ),
          // Text(
          //   '${companynewsitems.title}',
          //   style: TextStyle(
          //     fontSize: 14.sp,
          //     color: Colors.red,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   '${companynewsitems.description}',
          //   style: TextStyle(
          //     fontSize: 18.sp,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}
