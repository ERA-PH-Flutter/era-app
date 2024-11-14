import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/presentation/agent/listings/listingproperties/controllers/listing_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_text.dart';

class InteractivePropertyImage extends StatelessWidget {
  const InteractivePropertyImage({
    super.key,
    required this.images,
    required this.initialImageIndex,
  });

  final List<String> images;
  final int initialImageIndex;

  @override
  Widget build(BuildContext context) {
    final RxInt currentPage = RxInt(initialImageIndex);
    ListingController controller = Get.find<ListingController>();

    final PageController pageController =
        PageController(initialPage: initialImageIndex);
    return Scaffold(
      appBar: CustomAppbar(),
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          return Future.value(false);
        },
        child: Stack(
          children: [
            Positioned(
                top: 20.h,
                right: 0,
                left: 0,
                child: Obx(() {
                  return EraText(
                    text:
                        "${currentPage.value + 1} / ${controller.images.length}",
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  );
                })),
            PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: (value) => currentPage.value = value,
              itemBuilder: (context, index) {
                return Center(
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: FutureBuilder<String>(
                      future: FirebaseStorage.instance
                          .ref()
                          .child(images[index])
                          .getDownloadURL(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: Get.width,
                          );
                        } else {
                          return Center(child: Text('No image available.'));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.images.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: currentPage.value == index ? 12.w : 8.w,
                      height: currentPage.value == index ? 12.h : 8.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage.value == index
                            ? Colors.black
                            : Colors.black.withOpacity(0.5),
                      ),
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

       // Positioned(
              //   right: -20.w,
              //   child: IconButton(

              //     color: AppColors.black,
              //     icon: Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //       size: 40.sp,
              //     ),
              //     onPressed: () {
              //       if (currentPage.value < controller.images.length - 1) {
              //         pageController.nextPage(
              //           duration: Duration(milliseconds: 300),
              //           curve: Curves.easeInOut,
              //         );
              //       }
              //     },
              //   ),
              // ),
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class InteractivePropertyImage extends StatelessWidget {
//   const InteractivePropertyImage({super.key, required this.image});
//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Wrap(
//         alignment: WrapAlignment.center,
//         children: [
//           InteractiveViewer(
//             panEnabled: false, // Set it to false
//             // boundaryMargin: EdgeInsets.all(100),
//             minScale: 2,
//             maxScale: 6,
//             // not image widget.
//             child: FutureBuilder<String>(
//                 future: FirebaseStorage.instance
//                     .ref()
//                     .child(image)
//                     .getDownloadURL(),
//                 builder: (context, snapshot) {
//                   return Image.network(
//                     snapshot.data!,
//                     fit: BoxFit.cover,
//                   );
//                 }),
//           ),
//           // CloudStorage().imageLoader(
//           //   reference: controller.images[index],
//           //   fit: BoxFit.cover,
//           // ),
//         ],
//       ),
//     ));
//   }
// }