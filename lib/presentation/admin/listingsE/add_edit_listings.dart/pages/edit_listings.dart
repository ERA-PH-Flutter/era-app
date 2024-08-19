import 'package:eraphilippines/presentation/admin/listingsE/add_edit_listings.dart/controllers/add_edit_listings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//todo add text

class EditListingsAdmin extends GetView<AddEditListingsController> {
  const EditListingsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Agents'),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/loginpage');
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
