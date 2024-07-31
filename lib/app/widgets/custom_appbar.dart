import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/menuitems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.leading,
    this.action,
    this.height = 85,
  });
  final Widget? leading;
  final Widget? action;
  final double height;
//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fapp-bar%2Feraph_logo.png?alt=media&token=134716fb-da8a-4bb3-9ebc-911f68d4b2bc
//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2Fapp-bar%2Fmenubar.png?alt=media&token=893dd49a-a71a-46b6-8a91-888f2c8bcad8
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
              action ??
                  DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    customButton: Image.asset(
                      'assets/icons/menubar.png',
                      height: 64,
                      width: 64,
                    ),
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      const DropdownMenuItem<Divider>(
                          enabled: false,
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          )),
                      ...MenuItems.secondItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      MenuItems.onChanged(context, value! as MenuItem);
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      elevation: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.black.withOpacity(0.7),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 210,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.white.withOpacity(0.7),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      customHeights: [
                        ...List<double>.filled(
                          MenuItems.firstItems.length,
                          50,
                        ),
                        10,
                        ...List<double>.filled(
                            MenuItems.secondItems.length, 50),
                      ],
                      // padding: const EdgeInsets.only(left: 30, right: 30),
                    ),
                  )),
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

  @override
  Size get preferredSize => Size.fromHeight(height);
}
         // Transform.translate(
            //     offset: Offset(14, 1),
            //     child: IconButton(
            //       icon:  Image.asset(
            //         "assets/icons/menubar.png",
            //       ),
            //       onPressed: () {
            //         HomeController.logout();
            //       },
            //     )),