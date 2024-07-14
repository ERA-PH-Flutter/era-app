import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxWidget extends StatelessWidget {
  final Widget? child;
  const BoxWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
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
}
