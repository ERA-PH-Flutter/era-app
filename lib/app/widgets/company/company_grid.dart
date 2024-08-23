import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/company/company_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyGrid extends StatelessWidget {
  final List companymodels;
  const CompanyGrid({
    super.key,
    required this.companymodels,
  });

  @override
  Widget build(BuildContext context) {
    return companymodels.isNotEmpty
        ? SizedBox(
            height: 440.h,
            child: GridView.builder(
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 430.w, //410
              ),
              itemCount: companymodels.length,
              itemBuilder: (context, i) =>
                  CompanyItems(companyItems: companymodels[i],
                  showListedby: true,
                  ),
            ),
          )
        : SizedBox(
            height: 120.h,
            child: Center(
              child: EraText(
                text: 'No featured news!',
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
          );
  }
}
