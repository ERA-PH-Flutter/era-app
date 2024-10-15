import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:number_paginator/number_paginator.dart';

//ignore: must_be_immutable
class CustomPaginator extends StatelessWidget {
  int totalPages;
  RxInt currentPage;
  final Function(int) onPageSelected;

  CustomPaginator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(left: 200.w, right: 21.w),
        child: NumberPaginator(
          numberPages: totalPages,
          onPageChange: (index) {
            onPageSelected(index);
          },
          initialPage: currentPage.value,
          config: NumberPaginatorUIConfig(
            mode: ContentDisplayMode.dropdown,
            buttonSelectedForegroundColor: AppColors.black,
            buttonUnselectedForegroundColor: AppColors.black,
            buttonSelectedBackgroundColor: AppColors.black,
            buttonUnselectedBackgroundColor: AppColors.white,
          ),
          showNextButton: false,
          prevButtonBuilder: (context) => TextButton(
            onPressed: () {},
            child: Row(
              children: [
                EraText(
                  text: 'PAGE:',
                  color: AppColors.hint,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
