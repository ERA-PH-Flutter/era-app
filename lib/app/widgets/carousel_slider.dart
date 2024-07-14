 
 
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:flutter/widgets.dart';

class CarouselSliderWidget extends StatelessWidget {
  
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
        final List<String> images = [
      'assets/images/e1.JPG',
      'assets/images/e2.JPG',
      'assets/images/e3.JPG',
    ];

    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(color: AppColors.carouselBgColor),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
              items: images.map((imagePath) {
                return Builder(builder: (BuildContext context) {
                  return CustomImageViewer.show(
                      context: context,
                      url: imagePath,
                      fit: BoxFit.cover,
                      radius: 25.0);
                });
              }).toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.80,
                enlargeFactor: 0.4,
              )),
        ],
      ),
    );
  }
}
