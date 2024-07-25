import 'package:eraphilippines/app/models/agents_models.dart';
import 'package:eraphilippines/app/widgets/agents_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentListView extends StatelessWidget {
  final List<AgentsModels> agentsModels;
  const AgentListView({super.key, required this.agentsModels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: agentsModels.length,
      itemBuilder: (context, index) {
        return AgentsInfo(
          agentInfo: agentsModels[index],
          onTap: () {
            Get.toNamed('/agentInfo', arguments: agentsModels[index]);
          },
        );
      },
    );
  }
}
