import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum ContactState {
  loading,
  loaded,
  error,
}

class ContactusController extends GetxController {
  var store = Get.find<LocalStorageService>();
  TextEditingController username = TextEditingController();
  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');
}
