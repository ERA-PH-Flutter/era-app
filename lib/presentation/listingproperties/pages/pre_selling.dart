import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/listingproperties/controllers/listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreSelling extends GetView<ListingController> {
  const PreSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            EraText(
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
