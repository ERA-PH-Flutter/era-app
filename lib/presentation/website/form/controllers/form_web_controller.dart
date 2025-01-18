import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../app/services/local_storage.dart';
import '../../../agent/utility/controller/base_controller.dart';

class FormWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  //var buylandingState = BuyWebState.loading.obs;
  var faqs = [].obs;

  var isCheckedYes = false.obs;
  var isCheckedNotNow = false.obs;

  late YoutubePlayerController youtubePlayerController;

  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController emailAd = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController propertyLoc = TextEditingController();
  TextEditingController price = TextEditingController();

  final ScrollController scrollController = ScrollController();

  var isAtBottom = false.obs;

  var selectedProperty = RxnString();
  var propertyTypes = [
    'Pre-Selling',
    'Residential',
    'Commercial',
    'Rental',
    'Auction'
  ];
  var selectedValue = RxnString();

  var items = [
    'Agent',
    'Broker',
  ];
  //contact us
  TextEditingController usernameC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController numberC = TextEditingController();
  TextEditingController emailAC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  var selectedSubj = RxnString();

  var subject = [
    'General Inquiry',
    'Sales',
    'Tech Support',
  ];

  void _onScroll() {
    isAtBottom.value = scrollController.position.atEdge &&
        scrollController.position.pixels > 0;
  }

  submitContact() async {
    print("a");
    try {
      var contactDoc =
          FirebaseFirestore.instance.collection('contact_us').doc();
      await contactDoc.set({
        'id': contactDoc.id,
        'name': nameC.text,
        'contact_number': numberC.text,
        'email': emailAC.text,
        'message': messageC.text,
        'type': selectedSubj.value
      });
      BaseController().showSuccessDialog(
          title: "Success",
          description: "Wait for an admin to contact you!",
          hitApi: () {
            nameC.clear();
            numberC.clear();
            emailAC.clear();
            messageC.clear();
            selectedSubj.value = null;
            Get.back();
          });
    } catch (e, ex) {
      print(ex);
    }
  }

  submitSellProperty() async {
    print("acheck");
    try {
      var sellDoc =
          FirebaseFirestore.instance.collection('sell_properties').doc();
      await sellDoc.set({
        'id': sellDoc.id,
        'name': name.text,
        'contact_number': phoneNum.text,
        'email': emailAd.text,
        'type': selectedProperty.value,
        'location': propertyLoc.text,
        'price': price.text,
        'desc': message.text,
      });
      BaseController().showSuccessDialog(
          title: "Success",
          description:
              "Your Property info has been submitted to admin. Wait for an admin to contact you!",
          hitApi: () {
            name.clear();
            phoneNum.clear();
            emailAd.clear();
            selectedProperty.value = null;
            propertyLoc.clear();
            price.clear();
            message.clear();

            Get.back();
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController.addListener(_onScroll);
    // youtubePlayerController = YoutubePlayerController(
    //   initialVideoId: 'UcbQCfRCoeA',
    //   flags: YoutubePlayerFlags(
    //     autoPlay: false,
    //     mute: false,
    //     useHybridComposition: true,
    //   ),
    // );
    faqs.value = (await FirebaseFirestore.instance
            .collection('faq')
            .orderBy('type')
            .get())
        .docs;
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    youtubePlayerController.dispose();

    super.dispose();
  }
}
