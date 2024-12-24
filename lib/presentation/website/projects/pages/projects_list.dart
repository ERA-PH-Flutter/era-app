import 'package:eraphilippines/app/widgets/web/project_views_web.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/project_list_controller.dart';
import 'package:eraphilippines/presentation/website/projects/pages/project_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/screens.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../app/widgets/app_textfield.dart';
import '../../../../app/widgets/box_widget.dart';

import '../../../admin/properties/controllers/project_view_binding.dart';
import '../../../agent/listings/searchresult/controllers/searchresult_controller.dart';
import '../../../agent/utility/controller/base_controller.dart';
import '../../../global.dart';
import '../../landingpage/controller/homs_controller.dart';
//todo add text

class ProjectsList extends GetView<ProjectsListWebController> {
  const ProjectsList({super.key});
  @override
  Widget build(BuildContext context) {
    final SearchResultController searchController =
        Get.put(SearchResultController());
    Get.put(ProjectsListWebController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              EraText(
                text: 'Find Cutting-Edge Real Estate Projects',
                fontSize: EraTheme.h1,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              sb10(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidthAdmin * 5),
                child: BoxWidget.build(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Obx(() {
                        if (!searchController.showFullSearch.value) {
                          return Container(
                            height: 60.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: AppTextField(
                                onSuffixTap: () async {
                                  BaseController().showLoading();
                                  var projects = await AI(
                                          query: searchController
                                              .aiSearchController.text)
                                      .projectSearch();
                                  if (projects.isNotEmpty) {
                                    controller.projects.value = projects;
                                    controller.projectsListState.value =
                                        ProjectsListState.loaded;
                                  } else {
                                    controller.projectsListState.value =
                                        ProjectsListState.empty;
                                  }
                                  BaseController().hideLoading();
                                },
                                controller: searchController.aiSearchController,
                                hint: 'Use AI Search',
                                svgIcon: AppEraAssets.ai3,
                                bgColor: AppColors.white,
                                isSuffix: true,
                                obscureText: false,
                                suffixIcons: AppEraAssets.send),
                          );
                        }
                        return Container();
                      }),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              Obx(() => switch (controller.projectsListState.value) {
                    ProjectsListState.loading => _loading(),
                    ProjectsListState.loaded => _loaded(),
                    ProjectsListState.error => Screens.error(),
                    ProjectsListState.empty => Screens.empty(height: 240.h)
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Obx(() {
      List<Widget> projects = [];
      for (int i = 0; i < controller.projects.value.length; i++) {
        if (i >= controller.count.value - controller.pageSize &&
            i < controller.count.value) {
          projects.add(GestureDetector(
            onTap: () {
              projectArgument = controller.projects[i];
              Get.toNamed('/view-project/${controller.projects[i].id}');
            },
            child: Wrap(children: [
              Column(
                children: ProjectViewsWeb(project: controller.projects[i])
                    .buildPreview(),
              ),
            ]),
          ));
        }
      }
      return LoadMore(
          length: (controller.projects.length / controller.pageSize).floor(),
          child: Column(children: projects));
    });
  }

  LoadMore({
    child,
    length,
  }) {
    return Column(
      children: [
        child,
        sb50(),
        NumberPagination(
          fontSize: 18.sp,
          buttonRadius: 10.r,
          controlButtonSize: Size(30, 30),
          numberButtonSize: Size(35, 35),
          sectionSpacing: 1.w,
          betweenNumberButtonSpacing: 1,
          totalPages: length,
          currentPage: (controller.count.value / controller.pageSize).floor(),
          visiblePagesCount: length < 4 ? length : 4,
          onPageChanged: (page) {
            controller.count.value = controller.pageSize * page;
            print(controller.count.value);
            controller.scrollController.jumpTo(
              0,
            );
            // controller.scrollController.jumpTo(
            //   0,
            // );
            print('scroll jump to: ${controller.pageSize}');
          },
        ),
        sb50(),
      ],
    );
  }
}
