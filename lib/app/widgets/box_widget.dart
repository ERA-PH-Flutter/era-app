import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/radio_widgets.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxWidget extends StatelessWidget {
  final Widget? child;
  const BoxWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.hint,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColors.hint,
            width: 1.0,
          ),
        ),
        child: child,
      ),
    );
  }

  static Widget boxListing() {
    return BoxWidget(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          //Location
          AppTextField(
            hint: 'Location',
            svgIcon: 'assets/icons/marker.png',
            bgColor: AppColors.white,
          ),
          //property type
          SizedBox(height: 20.h),
          AppTextField(
            hint: 'Property Type',
            svgIcon: 'assets/icons/house.png',
            bgColor: AppColors.white,
          ),
          //price range
          SizedBox(height: 20.h),
          AppTextField(
            hint: 'Price Range',
            svgIcon: 'assets/icons/money.png',
            bgColor: AppColors.white,
          ),
          //ai search
          SizedBox(height: 20.h),
          AppTextField(
            hint: 'AI Search',
            svgIcon: 'assets/icons/send.png',
            bgColor: AppColors.white,
          ),
          SizedBox(height: 20.h),
          //radio widget
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RadioWidgets(),
              RadioWidgets(
                text: 'RENT',
              ),
            ],
          ),
          //search widget
          SearchWidget(),
        ],
      ),
    );
  }
}
