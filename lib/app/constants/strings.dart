class AppStrings{
  static String geminiKey = "AIzaSyCvORyZd7KwL_v81PTLsQs5-aDaPxQujtg";
}
extension NumberParsing on String {
  int toInt() {
    return int.parse(this);
  }
  double toDouble(){
    return double.parse(this);
  }
  bool isEmpty(){
    return this == "" ? true : false;
  }
}