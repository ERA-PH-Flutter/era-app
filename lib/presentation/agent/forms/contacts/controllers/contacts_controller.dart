import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
  TextEditingController aiSearch = TextEditingController();
  TextEditingController message = TextEditingController();
  var formKey = GlobalKey<FormState>();

  //inquire
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();

  TextEditingController mNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController desc = TextEditingController();

  late YoutubePlayerController youtubePlayerController;

  var faqs = [].obs;
  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  var selectedSubj = RxnString();

  var subject = [
    'General Inquiry',
    'Sales',
    'Tech Support',
  ];
  @override
  onInit() async {
    super.onInit();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'UcbQCfRCoeA',
      flags: YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
    faqs.value = (await FirebaseFirestore.instance
            .collection('faq')
            .orderBy('type')
            .get())
        .docs;
  }

  @override
  void onClose() {
    youtubePlayerController.dispose();
    super.onClose();
  }

  sumbitInquire() async {
    try {
      var inquiryContact =
          FirebaseFirestore.instance.collection('inquire_details').doc();
      await inquiryContact.set({
        'id': inquiryContact.id,
        'fname': fname.text,
        'lname': lname.text,
        'email': email.text,
        'mobile_num': mNumber.text,
        'desc': desc.text
      });
      BaseController().showSuccessDialog(
          title: "Message Sent",
          okayButton: "Close",
          description:
              "We've received your message and will get back to you soon. Thank you",
          hitApi: () {
            fname.clear();
            lname.clear();
            email.clear();
            mNumber.clear();
            desc.clear();

            Get.back();
          });
    } catch (e) {
      print(e);
    }
  }

  submitContact() async {
    try {
      var contactDoc =
          FirebaseFirestore.instance.collection('contact_us').doc();
      await contactDoc.set({
        'id': contactDoc.id,
        'name': name.text,
        'contact_number': number.text,
        'email': emailA.text,
        'message': message.text,
        'type': selectedSubj.value
      });
      BaseController().showSuccessDialog(
          title: "Message Sent",
          okayButton: "Close",
          description:
              "We've received your message and will get back to you soon. Thank you",
          hitApi: () {
            name.clear();
            number.clear();
            emailA.clear();
            message.clear();
            selectedSubj.value = null;
            Get.back();
          });
    } catch (e) {}
  }
}
