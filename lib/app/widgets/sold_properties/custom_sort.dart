import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSortPopup extends StatelessWidget {
  final String title;
  final Function(String) onSelected;

  final List<PopupMenuEntry<String>> menuItems;
  const CustomSortPopup({
    super.key,
    required this.title,
    required this.onSelected,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.blue),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      color: AppColors.white,
      icon: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15.sp,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: AppColors.white,
          ),
        ],
      ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => menuItems,
    );
  }
}
