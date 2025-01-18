import 'package:eraphilippines/app/widgets/web/navbar.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/project_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/web/project_views_web.dart';
import '../../../../repository/project.dart';

class ProjectViewWeb extends GetView<ProjectViewWebController> {
  const ProjectViewWeb({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProjectViewWebController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthAdmin * 3),
              height: Get.height,
              child: ProjectViewsWeb(project: Get.arguments),
            ),
          ],
        ),
      ),
    );
    //  Scaffold(
    //   // appBar: PreferredSize(
    //   //   preferredSize: Size.fromHeight(kToolbarHeight),
    //   //   child: Navbar(),
    //   // ),
    //   body: WillPopScope(
    //     onWillPop: () {
    //       Get.back();
    //       return Future.value(false);
    //     },
    //     child: SafeArea(
    //       child: Obx(() => switch (controller.projectViewState.value) {
    //             ProjectViewState.loading => _loading(),
    //             ProjectViewState.loaded => _loaded(),
    //             ProjectViewState.error => _error(),
    //             ProjectViewState.empty => _empty()
    //           }),
    //     ),
    //   ),
    // );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Get.height,
            child: ProjectViewsWeb(project: Project.getById(idArgument)),
          ),
        ],
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
