import 'dart:convert';

import 'package:get/get.dart';

class GeoCode{
  double lat;
  double lng;
  String apiKey;
  GeoCode({
    required this.lat,
    required this.lng,
    required this.apiKey,
  });
  reverse()async{
    String url = "https://api.eraphilippines.com?lat=$lat&lon=$lng&api_key=$apiKey";//"https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=$apiKey";
    var response = await GetConnect().get(url,headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,POST",
      "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
    });

    return GeoCodeResponse.fromJSON(response.body.runtimeType == String ? jsonDecode(response.body) : response.body);
  }
}

class GeoCodeResponse{
  String? displayName;
  String? region;
  String? province;
  String? city;
  String? suburb;
  String? barangay;
  GeoCodeResponse({
    this.displayName,
    this.region,
    this.province,
    this.city,
    this.suburb,
    this.barangay,
  });
  factory GeoCodeResponse.fromJSON(json){

    return GeoCodeResponse(
        displayName: json["display_name"].toString(),
        region: json["address"]["region"].toString(),
        province: (json["address"]["state"] ?? "Metro Manila").toString(),
        city: (json["address"]["town"] ?? json["address"]["city"]).toString(),
        suburb: json["address"]["suburb"].toString(),
        barangay: (json["address"]["village"] ?? json["address"]["neighbourhood"] ?? json["address"]["quarter"]).toString()
    );
  }
}