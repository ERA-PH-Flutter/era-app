import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_profile_card.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/listings/listedBy_widget.dart';

class AgentProfileAdmin extends GetView<AgentAdminController> {
  const AgentProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side (Agent Profile, Favorites, Latest News)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AgentProfileCard(
                  listing: RealEstateListing.listingsModels[0],
                )
                // Agent Profile Section
                // AgentProfileSection( ),

                // Favorites Section
                //FavoritesSection(),

                // Latest News Section
                // LatestNewsSection(),
              ],
            ),
          ),

          // Right Side (Property Status, Listings, Pagination)
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    height: 100.h,
                    width: 100.w,
                  )
                  // Property Status Section
                  //   PropertyStatusSection(),

                  // Listings Section
                  // Expanded(
                  //child: ListingsGrid(),
                  //    ),

                  // Pagination Section
                  //  PaginationSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Card(
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           // Profile Image and Info
//           Row(
//             children: [
//               CircleAvatar(radius: 40), // Replace with actual image
//               SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('FirstName LastName',
//                       style: TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text('Agent/Broker'),
//                   Text('Status'),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           // Contact Information
//           Row(children: [
//             Icon(Icons.phone),
//             SizedBox(width: 8),
//             Text('0000-000-0000')
//           ]),
//           Row(children: [
//             Icon(Icons.email),
//             SizedBox(width: 8),
//             Text('name@mail.com')
//           ]),
//           Row(children: [
//             Icon(Icons.location_on),
//             SizedBox(width: 8),
//             Text('City Location')
//           ]),
//           Row(children: [
//             Icon(Icons.business),
//             SizedBox(width: 8),
//             Text('ERA Ranking: PRC LICH 0000000')
//           ]),
//           SizedBox(height: 8),
//           // Edit and Delete Buttons
//           Row(
//             children: [
//               ElevatedButton(onPressed: () {}, child: Text('EDIT')),
//               SizedBox(width: 8),
//               ElevatedButton(onPressed: () {}, child: Text('DELETE')),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
