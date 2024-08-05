import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agentInfo-widget.dart';

import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';

import 'package:flutter/material.dart';

class AgentMyListing extends StatelessWidget {
  const AgentMyListing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FindingProperties(listingModels: RealEstateListing.listingsModels),
          ],
        ),
      ),
    );
  }

  // Widget agentInfo() {
  //   return Row(
  //     children: [
  //       Image.asset(
  //         '${listing.user.image}',
  //         width: 100.w,
  //         height: 110.h,
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: 5.w, left: 15.w),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             AgentDashBoard.agentText(
  //                 '${listing.user.firstname} ${listing.user.lastname}',
  //                 AppColors.blue,
  //                 18.sp,
  //                 FontWeight.bold,
  //                 1.2),
  //             AgentDashBoard.agentText('${listing.user.role}', AppColors.black,
  //                 12.sp, FontWeight.w400, 0.9),
  //             AgentDashBoard.agentContact(
  //                 AppEraAssets.whatsappIcon, '${listing.user.whatsApp}'),
  //             AgentDashBoard.agentContact(
  //                 AppEraAssets.emailIcon, '${listing.user.email}'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
