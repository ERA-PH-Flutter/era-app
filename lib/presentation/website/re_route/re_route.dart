import 'package:eraphilippines/presentation/website/re_route/re_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/web/navbar.dart';

class ReRoute extends GetView<ReRouteController>{
  final String? params;
  const ReRoute({this.params,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Get.currentRoute != "/privacy-policy" ? Navbar() : Container(),
            controller.args!.page
          ],
        ),
      ),
    );
  }

}