import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/services/local_storage.dart';

enum ContactState {
  loading,
  loaded,
  error,
}

class ContactusController extends GetxController {
  var store = Get.find<LocalStorageService>();
  TextEditingController username = TextEditingController();

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');
}
