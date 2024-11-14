import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InteractivePropertyImage extends StatelessWidget {
  const InteractivePropertyImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  // CloudStorage().imageLoader(
                  //   reference: controller.images[index],
                  //   fit: BoxFit.cover,
                  // ),

                  InteractiveViewer(
                    clipBehavior: Clip.none,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: FutureBuilder<String>(
                        future: FirebaseStorage.instance
                            .ref()
                            .child(image)
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
                        }),
                  ),
                ],
              ),
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
            ],
          ),
        ));
  }
}

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