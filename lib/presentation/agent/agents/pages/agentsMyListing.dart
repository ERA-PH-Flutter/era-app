import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/gridView_AllListings.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/listview_agent_allListings.dart';

import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgentMyListing extends StatelessWidget {
  const AgentMyListing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RealEstateListing? listing = Get.arguments;

    if (listing == null) {
      return Scaffold(
        appBar: AppBar(title: Text("No Listing")),
        body: Center(child: Text("No listing data provided.")),
      );
    }
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListviewAgent(agentsModels: [listing]),
            GridviewAlllistings(listingModels: [listing]),
          ],
        ),
      ),
    );
  }
}
