import 'dart:io';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/firebase_auth.dart';
import '../../../../app/services/local_storage.dart';
import '../../../global.dart';

enum LoginPageState {
  loading,
  loaded,
  error,
}

class LoginPageController extends GetxController with BaseController{
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
  var selectedTransaction5years = RxnString();

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
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
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
    showLoading();
    var login = await Authentication().login(email: email.text.trim(), password: password.text.trim());
    if (login != null) {
      var id = FirebaseAuth.instance.currentUser!.uid;
      user = await EraUser().getById(id);
      Get.find<LocalStorageService>().userID = id;
      Get.offAllNamed(RouteString.home);
    } else {
      showSuccessDialog(hitApi: (){
        Get.back();
        Get.back();
      },title: "Failed",description: "Incorrect credentials, please double check!");
    }
  }

  googleLogin() async {
    var googleLogin = await Authentication().signInWithGoogle();
    if(googleLogin != null){
      //todo check if user is reg
      user = await EraUser().getById(FirebaseAuth.instance.currentUser!.uid);
      Get.offAllNamed(RouteString.home);
    }else{
      showSuccessDialog(hitApi: (){

      },title: "Failed",description: "Something went wrong");
    }

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

  Future signUp()async{
    showLoading();
    print(email.text);
    await Authentication().signup(
        email: emailAd.text,
        password: 'eraaccount'
    );
    var id = await Authentication().login(
        email: emailAd.text,
        password: 'eraaccount'
    );
    var user = EraUser(
      id: id,
      firstname: firstName.text,
      lastname: lastName.text,
      age : age.text.toInt(),
      gender: selectedGender.value,
      whatsApp: contactNo.text,
      email: emailAd.text,
    );
    var userInfo = EraUserInfo(
      id: id,
      status: selectedStatus.value,
      recruiter: recruiter.text,
      education: selectedEducation.value,
      experience: experience.text.toInt(),
      transaction: selectedTransaction.value,
      pastTransaction: selectedTransaction.value,
      specialization: selectedSpeciality.value
    );
    await Authentication().logout();
    try{
      if(id != null){
        await user.add();
        await userInfo.add();
        showSuccessDialog(
            title: "Create account Success!",
            description: "Account creation was successful please wait for admin approval!",
            hitApi: (){
              Get.offAllNamed(RouteString.loginpage);
            }
        );
      }else{
        //throw Error();
      }
    }catch(error,ex){
      print(ex);
    }
  }
}