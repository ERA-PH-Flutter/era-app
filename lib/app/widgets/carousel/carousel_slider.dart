import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:flutter/widgets.dart';

class CarouselSliderWidget extends StatelessWidget {
  final Color? color;
  const CarouselSliderWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      decoration: BoxDecoration(color: color ?? AppColors.carouselBgColor),
      child: Stack(
        children: [
          CarouselSlider(
            items: CarouselModels.carouselModels.map((images) {
              return Builder(builder: (BuildContext context) {
                return CustomImage(
                  url: images,
                  border: Border.all(
                    color: AppColors.white,
                    width: 1,
                  ),
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