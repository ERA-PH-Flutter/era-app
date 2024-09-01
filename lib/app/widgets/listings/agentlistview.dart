import 'package:eraphilippines/app/widgets/listings/agents_items.dart';
import 'package:flutter/material.dart';

class AgentListView extends StatelessWidget {
  final List agentsModels;
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
            //todo redirect to agent with his listings
            //Get.toNamed('/agentDashBoard', arguments: agentsModels[index]);
          },
        );
      },
    );
  }
}
