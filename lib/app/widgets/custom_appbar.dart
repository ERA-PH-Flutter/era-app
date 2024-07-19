import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/menuitems.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.leading,
    this.action,
    this.height = 100,
  });
  final Widget? leading;
  final Widget? action;
  final double height;

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
                        "assets/images/eraph_logo.png",
                      ),
                      onPressed: () {},
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
                      ...List<double>.filled(MenuItems.secondItems.length, 50),
                    ],
                    // padding: const EdgeInsets.only(left: 30, right: 30),
                  ),
                )),
          ],
        )
      ],
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
         // Transform.translate(
            //     offset: Offset(14, 1),
            //     child: IconButton(
            //       icon: Image.asset(
            //         "assets/icons/menubar.png",
            //       ),
            //       onPressed: () {
            //         HomeController.logout();
            //       },
            //     )),