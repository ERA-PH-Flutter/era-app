import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectDivider extends StatelessWidget {
  final List<ProjectTextImageModels> textImage;
  final String? text;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  const ProjectDivider({
    super.key,
    required this.textImage,
    this.text,
    this.height,
    this.width,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: textImage
            .map(
              (item) => Center(
                child: Column(
                  children: [
                    Image.asset(
                      item.imageText,
                      width: width ?? 241.w,
                      height: height ?? 91.h,
                    ),
                    EraText(
                      text: item.text ?? '',
                      fontSize: fontSize ?? 15.sp,
                      color: color ?? AppColors.hint,
                    ),
                  ],
                ),
              ),
            )
            .toList());
  }

  // static Widget projectDivider2(String textImage, String text) {
  //   return Center(
  //     child: Column(
  //       children: [
  //          Image.asset(
  //           textImage,
  //           width: 500.w,
  //           height: 500.h,
  //         ),
  //         EraText(
  //           text: text,
  //           fontSize: 15.sp,
  //           color: AppColors.black,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
