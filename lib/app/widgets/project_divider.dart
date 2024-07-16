import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectDivider extends StatelessWidget {
  const ProjectDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: ProjectsModels1.projects
            .map(
              (project) => Center(
                child: Column(
                  children: [
                    Image.asset(
                      project.imageText,
                      width: 241.w,
                      height: 91.h,
                    ),
                    EraText(
                      text: project.text,
                      fontSize: 15.sp,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
            )
            .toList());
  }
}
