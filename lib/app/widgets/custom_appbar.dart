import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/menuitems.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../../presentation/agent/authentication/pages/login_page.dart';
import '../models/realestatelisting.dart';
import '../services/firebase_auth.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({
    super.key,
    this.leading,
    this.action,
    this.height = 85,
  });
  final Widget? leading;
  final Widget? action;
  final double height;
  var controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                      offset: Offset(-14, 1),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/eraph_logo.png',
                        ),
                        onPressed: () {
                          Get.toNamed('/home');
                        },
                      )),
              Row(
                children: [
                  action ??
                     (FirebaseAuth.instance.currentUser != null ? StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('messages').where("to",whereIn: ["all",FirebaseAuth.instance.currentUser!.uid]).snapshots(),
                        builder: (context,snapshot){
                          int count = 0;
                          if(snapshot.hasData){
                            count = snapshot.data!.docs.length;
                          }
                          return Container(
                            width: 80.w,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: (){
                                      //todo goto inbox
                                    },
                                    child: Icon(CupertinoIcons.mail,
                                        color: AppColors.hint, size: 60.sp),
                                  ),
                                ),
                                Positioned(
                                  top: 12.5,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20.r),
                                        border: Border.all(color: Colors.white,width: 3.w)
                                    ),
                                    width: 32.5.w,
                                    height: 32.5.w,
                                    child: EraText(
                                      text: count.toString(),
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ) : Container()),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: (){
                      controller.isShowing ? controller.hide() : controller.show();
                    },
                    child: OverlayPortal(
                      controller: controller,
                      overlayChildBuilder: (BuildContext context) {
                        return Positioned(
                          top: 120,
                          right: 0,
                          child: Wrap(
                            children: [
                              Container(
                                width: 240.w,
                                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.r),
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                child: Column(
                                  children: [
                                    _buildMenuCard('FIND PROPERTIES', (){
                                      Get.toNamed("/findproperties");
                                    }),
                                    _buildMenuCard('PROJECTS', (){
                                      Get.toNamed("/project");
                                    }),
                                    _buildMenuCard('FIND AGENTS', (){
                                      Get.toNamed("/findagents");
                                    }),
                                    _buildMenuCard('ABOUT US', (){
                                      Get.toNamed("/aboutus");
                                    }),
                                    FirebaseAuth.instance.currentUser != null ?  _buildMenuCard('MY DASHBOARD', (){
                                      Get.toNamed("/agentDashBoard",
                                          arguments: RealEstateListing.listingsModels.first);
                                    }) : Container(),
                                    _buildMenuCard('SELL PROPERTY', (){

                                    }),
                                    _buildMenuCard('MORTGAGE CALCULATOR', (){
                                      Get.toNamed("/mortageCalculator");
                                    }),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    _buildMenuCard(FirebaseAuth.instance.currentUser == null ? "LOGIN" : "LOGOUT", (){
                                      if (FirebaseAuth.instance.currentUser == null) {
                                        Get.toNamed("/loginpage");
                                      } else {
                                        Authentication().logout();
                                        Get.to(LoginPage(), binding: LoginPageBinding());
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(
                        AppEraAssets.menubar,
                        height: 65,
                        width: 65,
                      ),
                    ),
                  )
                  // Obx((){
                  //   return
                  //   // return DropdownButtonHideUnderline(
                  //   //     child: DropdownButton2(
                  //   //       customButton: Image.asset(
                  //   //         AppEraAssets.menubar,
                  //   //         height: 65,
                  //   //         width: 65,
                  //   //       ),
                  //   //       items: [
                  //   //         ...MenuItems.firstItems.map(
                  //   //               (item) => DropdownMenuItem<MenuItem>(
                  //   //             value: item,
                  //   //             child: MenuItems.buildItem(item),
                  //   //           ),
                  //   //         ),
                  //   //         const DropdownMenuItem<Divider>(
                  //   //             enabled: false,
                  //   //             child: Divider(
                  //   //               thickness: 2,
                  //   //               color: Colors.grey,
                  //   //             )),
                  //   //         ...MenuItems.secondItems.map(
                  //   //               (item) => DropdownMenuItem(
                  //   //             value: item.value,
                  //   //             child: MenuItems.buildItem(item.value),
                  //   //           ),
                  //   //         ),
                  //   //       ],
                  //   //       onChanged: (value) {
                  //   //         MenuItems.onChanged(context, value! as MenuItem);
                  //   //       },
                  //   //       buttonStyleData: ButtonStyleData(
                  //   //         height: 50.h,
                  //   //         elevation: 2,
                  //   //         decoration: BoxDecoration(
                  //   //           borderRadius: BorderRadius.circular(14),
                  //   //           color: Colors.transparent,
                  //   //         ),
                  //   //       ),
                  //   //       dropdownStyleData: DropdownStyleData(
                  //   //         width: 250.w,
                  //   //         decoration: BoxDecoration(
                  //   //           borderRadius: BorderRadius.circular(14),
                  //   //           color: Colors.white.withOpacity(0.8),
                  //   //         ),
                  //   //       ),
                  //   //       menuItemStyleData: MenuItemStyleData(
                  //   //         customHeights: [
                  //   //           ...List<double>.filled(
                  //   //             MenuItems.firstItems.length,
                  //   //             50,
                  //   //           ),
                  //   //           10,
                  //   //           ...List<double>.filled(
                  //   //               MenuItems.secondItems.length, 50),
                  //   //         ],
                  //   //         // padding: const EdgeInsets.only(left: 30, right: 30),
                  //   //       ),
                  //   //     ));
                  // })
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 85,
            child: Divider(
              thickness: 1,
              color: AppColors.hint.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
  _buildMenuCard(text,callback){
    return GestureDetector(
      onTap: callback,
      child: Card(
        color: AppColors.white,
        elevation: 4,
        child: SizedBox(
          // width: Get.width,
          height: 45.h,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: EraText(
                    textAlign: TextAlign.center,
                    text: text,
                    color: AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(height);
}
