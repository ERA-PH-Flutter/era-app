import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listings/agents_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgentListView extends StatelessWidget {
  final List<RealEstateListing> agentsModels;
  const AgentListView({super.key, required this.agentsModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: agentsModels.length,
      itemBuilder: (context, index) {
        return AgentsItems(
          agentInfo: agentsModels[index],
          onTap: () {
            Get.toNamed('/agentDashBoard', arguments: agentsModels[index]);
          },
        );
      },
    );
  }
}
