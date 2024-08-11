import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/agents_all_listings_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListviewAgent extends StatelessWidget {
  final List<RealEstateListing> agentsModels;
  const ListviewAgent({super.key, required this.agentsModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: agentsModels.length,
      itemBuilder: (context, index) {
        return AgentsAllListings(
          agentInfo: agentsModels[index],
          onTap: () {
            Get.toNamed('/agentDashBoard', arguments: agentsModels[index]);
          },
        );
      },
    );
  }
}
