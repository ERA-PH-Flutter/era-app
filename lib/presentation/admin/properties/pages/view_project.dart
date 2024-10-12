import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_textfield.dart';
import '../../../../app/widgets/search_widget.dart';
import '../../landingpage/controllers/landingpage_controller.dart';

class ViewProject extends StatefulWidget {
  const ViewProject({super.key});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(EraTheme.paddingWidthAdmin - 5.w),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                height: 50.h,
                // controller: controller.aiSearchController,
                //can't use the hide why is that?
                svgIcon: AppEraAssets.ai3,

                hint: 'SEARCH PROJECTS',
                bgColor: Colors.grey[200],
                suffixIcons: AppEraAssets.send,
                isSuffix: true,

                onSuffixTap: () {
                  // controller.onSearch();
                },
              ),
              sb40(),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('projects')
                    .orderBy('order_id')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;

                    return Container(
                      height: Get.height,
                      child: ReorderableListView.builder(
                        key: Key('viewProjects'),
                        onReorder: (oldIndex, newIndex) async {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          var projectsOld = data[oldIndex]['id'];
                          var projectsNew = data[newIndex]['id'];
                          var oldOrderId = data[oldIndex]['order_id'];
                          var newOrderId = data[newIndex]['order_id'];
                          await FirebaseFirestore.instance
                              .collection('projects')
                              .doc(projectsOld)
                              .update({
                            'order_id': newOrderId,
                          });
                          await FirebaseFirestore.instance
                              .collection('projects')
                              .doc(projectsNew)
                              .update({
                            'order_id': oldOrderId,
                          });
                          // final item = controller.projectLego.removeAt(oldIndex);
                          // controller.projectLego.insert(newIndex, item);
                        },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var d = data[index].data();
                          var developerName = "";
                          var projectTitle = "";
                          var image = '';
                          d['data'].forEach((lego) {
                            if (lego['type'] == "Developer Name") {
                              developerName = lego['developer_name'];
                            }
                            if (lego['type'] == "Project Title") {
                              projectTitle = lego['project_title'];
                            }
                            if (lego['type'] == "Project Logo") {
                              image = lego['image'];
                            }
                          });

                          return Container(
                            margin: EdgeInsets.only(bottom: 5.w),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  width: 2.w,
                                  color: settings!.featuredProjects!
                                          .contains(data[index]['id'])
                                      ? AppColors.kRedColor
                                      : Colors.transparent,
                                )),
                            key: Key('era$index'),
                            child: ListTile(
                              title: EraText(
                                  text: 'Developer Name: $developerName',
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                              subtitle: EraText(
                                  text: 'Project Title: $projectTitle',
                                  color: AppColors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                              trailing: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 1,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      if (settings!.featuredProjects!
                                          .contains(data[index]['id'])) {
                                        settings!.featuredProjects!.removeAt(
                                            settings!.featuredProjects!
                                                .indexOf(data[index]['id']));
                                        await settings!.update();
                                      } else {
                                        settings!.featuredProjects!
                                            .add(data[index]['id']);
                                        await settings!.update();
                                      }

                                      setState(() {});
                                    },
                                    child: EraText(
                                      text:
                                          "${settings!.featuredProjects!.contains(data[index]['id']) ? "Remove from" : "Add to"} Featured",
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      projectsData = data[index]['data'];
                                      projectId = data[index]['id'];
                                      await Get.delete<
                                          ListingsAdminController>();
                                      Get.put(ListingsAdminController());
                                      Get.find<LandingPageController>()
                                          .onSectionSelected(4);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('projects')
                                          .doc(d['id'])
                                          .delete();
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
