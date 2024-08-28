import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/widgets/box_widget.dart';

class PropertylistAdmin extends StatelessWidget {
  const PropertylistAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          EraText(
            text: 'PROPERTY LIST',
            fontSize: EraTheme.header,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 20),
          EraText(
            text: ' SEARCH',
            fontSize: EraTheme.header,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          BoxWidget.build(
            child: Row(
              children: const [
                Expanded(
                  child: TextformfieldWidget(
                    hintText: 'Search',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
