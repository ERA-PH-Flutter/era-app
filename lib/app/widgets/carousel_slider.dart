import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    final List<String> images = [
      'assets/images/carouselsliderpic2.jpg',
      'assets/images/carouselsliderpic3.jpg',
      'assets/images/carouselsliderpic4.jpg',
      'assets/images/carouselsliderpic5.jpg',
    ];

    return Container(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      decoration: BoxDecoration(color: AppColors.carouselBgColor),
      child: Stack(
        children: [
          // Carousel Slider
          CarouselSlider(
            items: images.map((imagePath) {
              return Builder(builder: (BuildContext context) {
                return CustomImage(
                  url: imagePath,
                );
              });
            }).toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlay: true,
              // enableInfiniteScroll: true,
              viewportFraction: 0.8,
              // aspectRatio: 16 / 9,
            ),
          ),
        ],
      ),
    );
  }
}
      // CarouselSlider(
          //   items: images.map((imagePath) {
          //     return Builder(builder: (BuildContext context) {
          //       return CustomImageViewer.show(
          //         context: context,
          //         url: imagePath,
          //         fit: BoxFit.cover,
          //         radius: 25.0,
          //       );
          //     });
          //   }).toList(),
          //   options: CarouselOptions(
          //     enlargeCenterPage: true,
          //     enlargeStrategy: CenterPageEnlargeStrategy.height,
          //     autoPlay: true,
          //     enableInfiniteScroll: true,
          //     viewportFraction: 0.80,
          //     enlargeFactor: 0.4,
          //   ),
          // ),