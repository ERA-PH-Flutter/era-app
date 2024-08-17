import 'dart:io';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/firebase_auth.dart';
import '../../../../app/services/local_storage.dart';

enum LoginPageState {
  loading,
  loaded,
  error,
}

class LoginPageController extends GetxController {
  Rx<File> image = File('').obs;
  final picker = ImagePicker();
  var store = Get.find<LocalStorageService>();
  var text = "".obs;
  var passwordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  var selectedGender = RxnString();
  var selectedEducation = RxnString();
  var selectedStatus = RxnString();
  var selectedSpeciality = RxnString();
  var selectedTransaction = RxnString();

  List<String> genderType = ['Female', 'Male'];
  List<String> educationType = ['High School', 'College', 'Masters', 'PhD'];
  List<String> statusType = [
    'License Broker',
    'Accredited Salesperson',
    'No license',
  ];
  List<String> specialityType = ['Rental', 'Primary', 'Resale', 'Others'];
  List<String> transaction = ['1-5', '6-10', 'More than 10'];

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();

  //create account
  TextEditingController fullName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailAd = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController recruiter = TextEditingController();
  TextEditingController educationL = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController specialization = TextEditingController();

  login() async {
    var login = await Authentication()
        .login(email: email.text.trim(), password: password.text.trim());
    if (login != null) {
      //todo assign local user
      Get.offAllNamed(RouteString.home);
    } else {
      //todo show error
    }
  }

  googleLogin() async {
    print(await Authentication().signInWithGoogle());
    //Get.offAllNamed(RouteString.home);
  }

  Future getImageGallery() async {
    try {
      final imagePick = await picker.pickImage(source: ImageSource.gallery);
      if (imagePick != null) {
        image.value = File(imagePick.path);
      }
    } on PlatformException catch (e) {
      return e;
    }
  }
}
// if (pickedFile != null) {
//       image.value = File(pickedFile.path);
//     } else {
//       print('No image selected.');
//     }