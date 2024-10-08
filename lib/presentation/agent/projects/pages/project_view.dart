import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../app/widgets/project_views.dart';
import '../../../admin/properties/controllers/project_view_controller.dart';

class ProjectView extends GetView<ProjectViewController> {
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
      child: Container(
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
