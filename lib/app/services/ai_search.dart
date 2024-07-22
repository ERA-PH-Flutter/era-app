import 'package:flutter_gemini/flutter_gemini.dart';

class AI{
  String query;
  final gemini = Gemini.instance;
  AI({
    required this.query
  });
  search(){
    String prompt = "write an mysql string text using this text search $query here are the available properties for mysql (location, type (apartment, condo, house, subdivision), status (pre selling, sold, selling, new, rent), size, No. of rooms, No. Of baths, No. of Balcony, Amenities (gym or landmarks nearby), Garage View ( sunset, sunrise, mountain, beach, city etc.), price) give me mysql string only don't add any other text";
    gemini.text(query)
      .then((value){
        print(value);
      }).catchError((e) => print(e));
  }

}