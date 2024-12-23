import 'package:eraphilippines/presentation/website/re_route/re_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReRoute extends GetView<ReRouteController>{
  const ReRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //navbar
          controller.args!.page
        ],
      ),
    );
  }

}