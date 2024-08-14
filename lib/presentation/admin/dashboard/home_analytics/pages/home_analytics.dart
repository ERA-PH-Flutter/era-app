import 'package:flutter/material.dart';
import 'package:get/get.dart';

//todo add text

class HomeAnalytics extends GetView<HomeAnalytics> {
  const HomeAnalytics({super.key});

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
