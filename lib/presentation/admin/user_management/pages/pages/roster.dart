import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/services/firebase_auth.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';

import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../repository/user.dart';

class Roster extends GetView<AgentAdminController> {
  const Roster({super.key});

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
              text: 'FIND AGENT',
              color: AppColors.kRedColor,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.bold,
            ),
            buildField(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: Get.width - 520.w),
              child: Button(
                onTap: ()async{
                  controller.agentState.value = AgentAdminState.loading;
                  controller.searchStream = controller.getStream();
                  // await Future.delayed(Duration(seconds: 1));
                  controller.agentState.value = AgentAdminState.loaded;
                },
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                text: 'SEARCH',
                fontSize: EraTheme.buttonFontSizeSmall,
                bgColor: AppColors.kRedColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Obx((){
              if(controller.agentState.value == AgentAdminState.loaded){
                return StreamBuilder(
                  stream: controller.searchStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EraUser> users = snapshot.data!.docs.map((doc) {
                        return EraUser.fromJSON(doc.data());
                      }).toList();
                      return rosterGridview(listingModels: users);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }else{
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
                            agentType: "${listingModels[i].role}",
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
                              margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
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
                                menuOptions("Message", () async {
                                  Get.dialog(AlertDialog(
                                    backgroundColor: AppColors.white,
                                    title: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.black,
                                          ),
                                        )),
                                    content: Wrap(
                                      children: [
                                        SizedBox(
                                          width: Get.width / 2.5,
                                          child: Column(
                                            children: [
                                              TextformfieldWidget(
                                                controller: controller.title,
                                                hintText: 'TITLE',
                                                maxLines: 1,
                                                fontSize: 15.sp,
                                                textInputAction:
                                                TextInputAction.newline,
                                                keyboardType:
                                                TextInputType.multiline,
                                                color: AppColors.hint,
                                              ),
                                              sb10(),
                                              TextformfieldWidget(
                                                controller: controller.message,
                                                hintText:
                                                'Type your message here',
                                                maxLines: 5,
                                                fontSize: 15.sp,
                                                textInputAction:
                                                TextInputAction.newline,
                                                keyboardType:
                                                TextInputType.multiline,
                                                color: AppColors.hint,
                                              ),
                                              sb30(),
                                              Button(
                                                width: Get.width,
                                                onTap: () async {
                                                  var messageDoc = FirebaseFirestore.instance.collection('messages').doc();
                                                  var message = await messageDoc.set({
                                                    'date' : DateTime.now(),
                                                    'from' : "${user!.firstname ?? "ERA Admin"} ${user!.lastname ?? ""}",
                                                    "title" : controller.title.text,
                                                    'subject' : controller.message.text,
                                                    'to' : listingModels[i].id
                                                  });
                                                  BaseController().showSuccessDialog(
                                                    title: "Success",
                                                    description: "Message has been sent!",
                                                    hitApi: (){
                                                      controller.title.clear();
                                                      controller.message.clear();
                                                      Get.back();Get.back();
                                                    }
                                                  );
                                                },
                                                fontSize: EraTheme
                                                    .buttonFontSizeSmall,
                                                text: 'SUBMIT',
                                                bgColor: AppColors.blue,
                                                borderRadius:
                                                BorderRadius.circular(30),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                  // todo open modal with message textfield title and description
                                }, CupertinoIcons.chat_bubble_fill),
                                menuOptions("Edit", () async {
                                  Get.find<AgentAdminController>().setValues(listingModels[i]);
                                  controllers.onSectionSelected(1);
                                }, Icons.edit),
                                menuOptions("Delete", () async {
                                  await listingModels[i].delete();
                                }, Icons.delete_rounded),
                              ])),
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


  // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //   Button(
            //     onTap: () {
            //       //NOT DONE YET TO DO NIKKO
            //       BaseController().showSuccessDialog(
            //           title: "Confirm",
            //           description: "Do you want to delete this User?",
            //           hitApi: () async {
            //             BaseController().showLoading();
            //             await EraUser().delete();
            //             BaseController().hideLoading();

            //             Get.back();
            //           },
            //           cancelable: true);
            //     },
            //     width: 170.w,
            //     fontSize: EraTheme.buttonFontSizeSmall,
            //     text: 'DELETE',
            //     bgColor: AppColors.kRedColor,
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            //   sbw10(),
            //   Button(
            //     onTap: () {
            //       Get.dialog(
            // AlertDialog(
            //         backgroundColor: AppColors.white,
            //         title: GestureDetector(
            //             onTap: () {
            //               Get.back();
            //             },
            //             child: Align(
            //               alignment: Alignment.centerRight,
            //               child: Icon(
            //                 Icons.close,
            //                 color: AppColors.black,
            //               ),
            //             )),
            //         content: Stack(
            //           children: [
            //             SizedBox(
            //               height: 250.h,
            //               width: Get.width - 400.w,
            //               child: Column(
            //                 children: [
            //                   TextformfieldWidget(
            //                     controller: controller.message,
            //                     hintText: 'Type your message here',
            //                     maxLines: 5,
            //                     fontSize: 15.sp,
            //                     textInputAction: TextInputAction.newline,
            //                     keyboardType: TextInputType.multiline,
            //                     color: AppColors.hint,
            //                   ),
            //                   sb30(),
            //                   Button(
            //                     onTap: () {},
            //                     width: 170.w,
            //                     fontSize: EraTheme.buttonFontSizeSmall,
            //                     text: 'SUBMIT',
            //                     bgColor: AppColors.blue,
            //                     borderRadius: BorderRadius.circular(30),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ));
            //     },
            //     width: 170.w,
            //     fontSize: EraTheme.buttonFontSizeSmall,
            //     text: 'MESSAGE',
            //     bgColor: AppColors.blue,
            //     borderRadius: BorderRadius.circular(30),
            //   ),
            // ]),