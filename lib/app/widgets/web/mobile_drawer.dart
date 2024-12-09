import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presentation/website/landingpage/controller/homs_controller.dart';
import '../../constants/colors.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class AppDrawer extends GetView<HomsController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: drawerText(text: 'Home'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 0;
              controller.navBarSelectedIndex.value = 0;
              //  Navigator.pop(context);
            },
          ),
          ListTile(
            title: drawerText(text: 'Buy'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 1;
              controller.navBarSelectedIndex.value = 1;

              //  Navigator.pop(context);
            },
          ),
          ListTile(
            title: drawerText(text: 'Sell'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 2;
              controller.navBarSelectedIndex.value = 2;
            },
          ),
          ListTile(
            title: drawerText(text: 'Rent'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 3;
              controller.navBarSelectedIndex.value = 3;
            },
          ),
          ListTile(
            title: drawerText(text: 'Projects'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 4;
              controller.navBarSelectedIndex.value = 4;
            },
          ),
          ListTile(
            title: drawerText(text: 'News'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 5;
              controller.navBarSelectedIndex.value = 5;
            },
          ),
          ListTile(
            title: drawerText(text: 'Contact Us'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 6;
              controller.navBarSelectedIndex.value = 6;
            },
          ),
          ListTile(
            title: drawerText(text: 'Join Era'.toUpperCase()),
            onTap: () {
              selectedIndex.value = 7;
              controller.navBarSelectedIndex.value = 7;
            },
          ),
        ],
      ),
    );
  }

  Widget drawerText({text}) {
    return Obx(() => EraText(
          text: text,
          color: controller.navBarSelectedIndex.value ==
                  controller.items.indexOf(text)
              ? AppColors.kRedColor
              : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: EraTheme.subHeaderWeb,
        ));
  }
}
