import 'package:eraphilippines/presentation/website/home_website/controllers/home_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/services/firebase_storage.dart';
import '../../../../app/widgets/app_text.dart';

// class BannersWidget extends GetView<HomeWebController> {
//   final String image;
//   final String label;
//   const BannersWidget({super.key, required this.image, required this.label}); 

//   @override
//   Widget build(BuildContext context) {
//     HomeWebController controller = Get.put(HomeWebController());
//     var listingsImages = controller.listingImages;
//     return StaggeredGridView.countBuilder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 3,
//       itemCount: listingsImages.length,
//       crossAxisSpacing: 16.0,
//       mainAxisSpacing: 16.0,
//       itemBuilder: (context, index) {
//         return _buildUploadPhoto(
//           text: image,
//           image: label,
//         );
//       },
//       staggeredTileBuilder: (index) {
//         if (index == 2) {
//           return StaggeredTile.count(1, 2);
//         } else {
//           return StaggeredTile.count(1, 1);
//         }
//       },
//     );
//   }
// }

// Widget _buildUploadPhoto({required String text, Widget? image}) {
//   return Stack(
//     children: [
//       image != null
//           ? CloudStorage().imageLoaderProvider(
//               ref: image,
//               borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
//             )
//           : Image.asset(
//               AppEraAssets.noImageWhite,
//               fit: BoxFit.cover,
//             ),
//       Positioned(
//         bottom: 20,
//         left: 10,
//         child: EraText(
//           text: text,
//           style: TextStyle(
//               fontSize: EraTheme.headerWeb - 5.sp,
//               color: AppColors.white,
//               fontWeight: FontWeight.bold,
//               shadows: const [
//                 Shadow(
//                   color: Colors.black,
//                   blurRadius: 5,
//                   offset: Offset(2, 2),
//                 )
//               ]),
//         ),
//       )
//     ],
//   );
// }
