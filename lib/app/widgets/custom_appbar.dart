import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
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
        child: Container(
      height: height,
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
                  Transform.translate(
                      offset: Offset(14, 1),
                      child: IconButton(
                        icon: Image.asset(
                          "assets/icons/menubar.png",
                        ),
                        onPressed: () {
                          HomeController.logout();
                        },
                      )),
            ],
          )
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
