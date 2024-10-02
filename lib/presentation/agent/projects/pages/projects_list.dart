import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/widgets/project_views.dart';
import '../../../admin/properties/controllers/project_list_controller.dart';
import '../../../admin/properties/controllers/project_view_binding.dart';
//todo add text

class ProjectsList extends GetView<ProjectsListController> {
  const ProjectsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.projectsListState.value) {
                ProjectsListState.loading => _loading(),
                ProjectsListState.loaded => _loaded(),
                ProjectsListState.error => _error(),
                ProjectsListState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return Container(
      height: Get.height - 200.h,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.projects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(ProjectView(),
                    binding: ProjectViewBinding(),
                    arguments: controller.projects[index]);
              },
              child: Container(
                child: Column(
                  children: ProjectViews(project: controller.projects[index])
                      .buildPreview(),
                ),
              ),
            );
          }),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
