class AppStrings{
  static String geminiKey = "AIzaSyCvORyZd7KwL_v81PTLsQs5-aDaPxQujtg";
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
}