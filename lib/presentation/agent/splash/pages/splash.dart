import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/app_text.dart';
import '../controllers/splash_controller.dart';

class Splash extends GetView<SplashController>{
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx((){
          if(controller.splashState.value == SplashState.loading){
            return _loading();
          }else if(controller.splashState.value == SplashState.loaded){
            return _loaded();
          }else{
            return _error();
          }
        }),
      ),
    );
  }
  _loaded(){

  }
  _loading(){
    return const Center(
      child: EraText(
        text: "ADS GOES HERE"
      ),
    );
  }
  _error(){

  }
}