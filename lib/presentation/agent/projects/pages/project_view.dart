import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/widgets/project_views.dart';
import '../../../admin/properties/controllers/project_view_controller.dart';

class ProjectView extends GetView<ProjectViewController> {
  const ProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.projectViewState.value) {
                ProjectViewState.loading => _loading(),
                ProjectViewState.loaded => _loaded(),
                ProjectViewState.error => _error(),
                ProjectViewState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height,
        child: ProjectViews(project: Get.arguments).build(),
      ),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
