import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';
//todo add text

class AdminHome extends GetView<AdminHomeController> {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Agents'),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/loginpage');
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
