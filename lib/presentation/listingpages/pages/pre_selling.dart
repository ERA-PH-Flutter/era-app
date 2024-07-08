import 'package:architecture/app/widgets/app_text.dart';
import 'package:architecture/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PreSelling extends GetView<HomeController> {
  const PreSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            FarmerText(
              text: 'PRE-SELLING',
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
