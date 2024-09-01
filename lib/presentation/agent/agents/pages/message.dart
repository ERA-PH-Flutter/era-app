import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/inbox_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatelessWidget {
  final Message message;

  const MessageScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Card(
            elevation: 8,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(EraTheme.paddingWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: message.title,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                  SizedBox(height: 8.h),
                  EraText(
                    text: message.time,
                    color: AppColors.hint,
                  ),
                  SizedBox(height: 16.h),
                  EraText(
                    text: message.subject,
                    color: AppColors.black,
                    fontSize: 15.sp,
                    maxLines: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
