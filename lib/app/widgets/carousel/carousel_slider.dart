import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:flutter/widgets.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String> images;
  final Color? color;

  const CarouselSliderWidget({
    super.key,
    required this.images,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
      decoration: BoxDecoration(color: color ?? AppColors.carouselBgColor),
      child: CarouselSlider(
        items: images.map((imageUrl) {
          return Builder(builder: (BuildContext context) {
            return CustomImage(
              url: imageUrl,
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
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
