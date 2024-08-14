import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/listingsAdmin_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<ListingsAdminController>{
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(()=>switch(controller.listingState.value){
            ListingsAState.loading => _loading(),
            ListingsAState.loaded => _loaded(),
            ListingsAState.error => _error(),
            ListingsAState.empty => _empty()
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