import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';
import '../../../utility/controller/base_controller.dart';

enum ContactState {
  loading,
  loaded,
  error,
}

class ContactusController extends GetxController {
  var store = Get.find<LocalStorageService>();
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController emailA = TextEditingController();
  TextEditingController message = TextEditingController();
  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  var selectedSubj = RxnString();

  var subject = [
    'General Inquiry',
    'Sales',
    'Tech Support',
  ];

  submitContact()async{
    print("a");
    try {
      var contactDoc = FirebaseFirestore.instance
          .collection('contact_us')
          .doc();
      await contactDoc.set({
        'id': contactDoc.id,
        'name': name.text,
        'contact_number': number.text,
        'email': emailA.text,
        'message': message.text,
        'type' : selectedSubj.value
      });
      BaseController().showSuccessDialog(
          title: "Success",
          description:
          "Wait for an admin to contact you!",
          hitApi: () {
            name.clear();
            number.clear();
            emailA.clear();
            message.clear();
            selectedSubj.value = null;
            Get.back();
          });
    } catch (e, ex) {
      print(ex);
    }
  }
}
