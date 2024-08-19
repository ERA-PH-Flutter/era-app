class AppStrings{
  static String geminiKey = "AIzaSyCvORyZd7KwL_v81PTLsQs5-aDaPxQujtg";
  static String noImageWhite = 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/images%2Fno_image_listings_white.png?alt=media&token=05793fda-3509-4d0c-89d2-ebcfdc8d9023';
  static String noUserImageWhite = 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/images%2Fno_image_user_white.png?alt=media&token=6f5b1d56-96b0-41ec-b33f-d05c6e8422b0';
}


extension NumberParsing on String {
  int toInt() {
    try{
      return int.parse(this);
    }catch(e){
      return 0;
    }
  }
  double toDouble(){
    try{
      return double.parse(this);
    }catch(e){
      return 0;
    }
  }
  bool isEmpty(){
    return this == "" ? true : false;
  }
  String notEmpty(value){
    return this == 'null' || this == '' ? value : this;
  }
}