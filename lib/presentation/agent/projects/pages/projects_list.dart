import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
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
import '../../../../app/widgets/project_views.dart';

import '../../../../repository/project.dart';
import '../../../admin/properties/controllers/project_list_controller.dart';
import '../../../admin/properties/controllers/project_view_binding.dart';
import '../../listings/searchresult/controllers/searchresult_controller.dart';
//todo add text

class ProjectsList extends GetView<ProjectsListController> {
  const ProjectsList({super.key});
  @override
  Widget build(BuildContext context) {
    final SearchResultController searchController = Get.put(SearchResultController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          // selectedIndex.value = 0;
          // pageViewController = PageController(initialPage: 0);
          // currentRoute = '/home';
          // Get.offAll(BaseScaffold(), binding: HomeBinding());
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                      child: EraText(
                        text: 'Find Cutting-Edge Real Estate Projects',
                        fontSize: 30.sp,
                        color: AppColors.kRedColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    sb10(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                      child: BoxWidget.build(
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Obx(() {
                              if (!searchController.showFullSearch.value) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: AppTextField(
                                      onSuffixTap: () async {
                                        BaseController().showLoading();
                                        var projects = await AI(query: searchController.aiSearchController.text).projectSearch();
                                        print(projects);
                                        if(projects.isNotEmpty){
                                          controller.projects.value = projects.map((proj){
                                            return Project.fromJSON(proj.data());
                                          }).toList();
                                          controller.projectsListState.value = ProjectsListState.loaded;
                                        }else{
                                          controller.projectsListState.value = ProjectsListState.empty;
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
                  ],
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
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Obx((){
      List<Widget> projects = [];
      for (int i = 0; i < controller.projects.value.length; i++) {
        if(i >= controller.count.value - controller.pageSize && i < controller.count.value){
          projects.add(GestureDetector(
            onTap: () {
              Get.to(ProjectView(),
                  binding: ProjectViewBinding(),
                  arguments: controller.projects[i]);
            },
            child: Wrap(children: [
              Column(
                children: ProjectViews(project: controller.projects[i])
                    .buildPreview(),
              ),
            ]),
          ));
        }
      }
      return LoadMore(
        length: (controller.projects.length / controller.pageSize).floor(),
        child: Column(children: projects)
      );
    });
  }
  LoadMore({
    child,
    length,
  }){
    return Column(
      children: [
        child,
        NumberPagination(
          fontSize: 18.sp,
          buttonRadius:10.r,
          controlButtonSize: Size(30 ,30),
          numberButtonSize: Size(35, 35),
          sectionSpacing:1.w,
          betweenNumberButtonSpacing: 1,
          totalPages: length,
          currentPage: (controller.count.value / controller.pageSize).floor(),
          visiblePagesCount: length < 4 ? length : 4,
          onPageChanged: (page){
            controller.count.value = controller.pageSize * page;
          },
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
