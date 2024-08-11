import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';
//todo add text

class Base extends GetView<BaseController>{
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(()=>switch(controller.baseState.value){
            BaseState.loading => _loading(),
            BaseState.loaded => _loaded(),
            BaseState.error => _error(),
            BaseState.empty => _empty()
          }),
        ),
      ),
    );
  }
  _loading(){
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
  _loaded(){
    return Column(
      children: const [

      ],
    );
  }
  _error(){
    //todo add error screen
  }
  _empty(){
    //todo add empty screen
  }
}