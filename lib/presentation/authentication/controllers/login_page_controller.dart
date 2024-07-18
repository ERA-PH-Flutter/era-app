import 'dart:io';

import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/services/firebase_auth.dart';
import '../../../app/services/local_storage.dart';

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
  var email = TextEditingController();
  var password = TextEditingController();
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