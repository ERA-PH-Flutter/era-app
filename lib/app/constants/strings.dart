class AppStrings{
  static String geminiKey = "AIzaSyCvORyZd7KwL_v81PTLsQs5-aDaPxQujtg";
  static String noImageWhite = 'images/no_image_listings_white.png';
  static String noUserImageWhite = 'images/no_image_user_white.png';
  static String googleMapKey = "AIzaSyAM1j4EgsFnh9cxf9STqVdNMFLJ9yRb-lo";
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
      return 0.0;
    }

  }
  bool isEmpty(){
    return this == "" ? true : false;
  }
  String notEmpty(value){
    return this == 'null' || this == '' ? value : this;
  }
}