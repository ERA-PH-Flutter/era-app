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
  Future<GeoCodeResponse> reverse()async{
    String url = "https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=$apiKey";
    var response = await GetConnect().get(url);
    return GeoCodeResponse.fromJSON(response.body);
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
        displayName: json["display_name"],
        region: json["address"]["region"],
        province: json["address"]["state"] ?? "Metro Manila",
        city: json["address"]["town"] ?? json["address"]["city"],
        suburb: json["address"]["suburb"],
        barangay: json["address"]["village"] ?? json["address"]["neighbourhood"] ?? json["address"]["quarter"]
    );
  }
}