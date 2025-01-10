import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../repository/user.dart';

class DeletedRoster extends GetView<AgentAdminController> {
  const DeletedRoster({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            EraText(
              text: 'AGENT CARD VIEW',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10.h),
            EraText(
              text: 'DELETED AGENT',
              color: AppColors.kRedColor,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.bold,
            ),
            // buildField(),
            // SizedBox(height: 10.h),
            // Padding(
            //   padding: EdgeInsets.only(left: Get.width - 520.w),
            //   child: Button(
            //     onTap: () async {
            //       controller.agentState.value = AgentAdminState.loading;
            //       controller.searchStream =
            //           controller.getStream(status: 'deleted');
            //       // await Future.delayed(Duration(seconds: 1));
            //       controller.agentState.value = AgentAdminState.loaded;
            //     },
            //     margin: EdgeInsets.symmetric(horizontal: 5),
            //     width: 150.w,
            //     text: 'SEARCH',
            //     fontSize: EraTheme.buttonFontSizeSmall,
            //     bgColor: AppColors.kRedColor,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            Obx(() {
              if (controller.agentState.value == AgentAdminState.loaded) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('full_name')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EraUser> users = [];
                      for (var doc in snapshot.data!.docs) {
                        if (doc.data()['status'] == "deleted") {
                          users.add(
                            EraUser.fromJSON(
                              {...doc.data(), 'id': doc.id},
                            ),
                          );
                        }
                      }
                      return rosterGridview(listingModels: users);
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget rosterGridview({required List<EraUser> listingModels}) {
    LandingPageController controllers = Get.put(LandingPageController());
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 20.w,
        left: 10.w,
        right: 10.w,
      ),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 480.h,
          crossAxisCount: 3,
          crossAxisSpacing: 40.w,
          mainAxisSpacing: 30.h),
      itemCount: listingModels.length,
      itemBuilder: (context, i) {
        var more = false.obs;
        return Wrap(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: AppColors.hint.withOpacity(0.5), width: 3),
                borderRadius: BorderRadius.circular(10),
              ),
              color: AppColors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: AppColors.hint.withOpacity(0.5),
                        child: GestureDetector(
                          onTap: () {
                            controllers.onSectionSelected(0);
                          },
                          child: ListedBy(
                            text: '',
                            image: "${listingModels[i].image}",
                            agentFirstName: "${listingModels[i].firstname}",
                            agentLastName: "${listingModels[i].lastname}",
                            agentRole: "${listingModels[i].role}",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, top: 20.h),
                        child: EraText(
                          text: "Profile Overview",
                          fontSize: 18.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.w, top: 10.h, right: 25.w),
                        child: EraText(
                          text: "${listingModels[i].description}",
                          fontSize: 15.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, top: 20.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              listingModels[i].whatsApp == null
                                  ? AppEraAssets.whatsappIcon
                                  : AppEraAssets.whatsappIcon,
                              width: 40.w,
                              height: 40.h,
                            ),
                            EraText(
                              text: "${listingModels[i].whatsApp}",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              lineHeight: 0.h,
                            ),
                          ],
                        ),
                      ),
                      sb10(),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              listingModels[i].email == null
                                  ? AppEraAssets.emailIcon
                                  : AppEraAssets.emailIcon,
                              width: 40.w,
                              height: 40.h,
                            ),
                            EraText(
                              text: "${listingModels[i].email}",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              lineHeight: 0.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                  Positioned(
                      top: 25.h,
                      right: 15.h,
                      child: IconButton(
                        onPressed: () {
                          more.value = true;
                        },
                        icon: Icon(
                          Icons.more_horiz_rounded,
                          color: Colors.black,
                          shadows: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Colors.white,
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                        ),
                      )),
                  Obx(() {
                    if (more.value == true) {
                      return Wrap(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        color: Colors.black38)
                                  ]),
                              child: Column(children: [
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        more.value = false;
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 25.sp,
                                        color: Colors.black,
                                        shadows: const [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              color: Colors.white,
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ],
                                      ),
                                    )),
                                menuOptions("Restore", () async {
                                  // Get.find<AgentAdminController>()
                                  //     .setValues(listingModels[i]);
                                  // controllers.onSectionSelected(1);
                                  controller.agentState.value =
                                      AgentAdminState.loading;
                                  try {
                                    listingModels[i].status = "approved";
                                    await listingModels[i].update();
                                  } catch (e) {
                                    print("eeerror: $e");
                                  }
                                  controller.agentState.value =
                                      AgentAdminState.loaded;
                                }, Icons.edit),
                              ])),
                          menuOptions("Permanent Delete", () async {
                            controller.agentState.value =
                                AgentAdminState.loading;
                            await listingModels[i].deleteOtherUser(
                                userId: listingModels[i].id ?? '');
                            controller.agentState.value =
                                AgentAdminState.loaded;
                          }, Icons.delete_forever)
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static menuOptions(text, callback, icon) {
    var isHover = false.obs;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        isHover.value = true;
      },
      onExit: (event) {
        isHover.value = false;
      },
      child: GestureDetector(
        onTap: callback,
        child: Obx(() => Container(
              alignment: Alignment.center,
              width: Get.width,
              color: isHover.value ? AppColors.kRedColor : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 25.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  EraText(
                    text: text,
                    fontSize: 18.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildField() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: "Full Name",
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: Get.width,
              child: TextformfieldWidget(
                controller: controller.fNameA,
                fontSize: 12.sp,
                maxLines: 1,
              ),
            ),
          ],
        ),
        buildFormField('Phone Number *', controller.phoneNA, 'Email *',
            controller.emailAdressA),
      ],
    );
  }

  Widget buildFormField(String name, TextEditingController controller,
      String name2, TextEditingController controller2) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name2,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller2,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
