import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/foundation.dart';

import '../presentation/global.dart';

class Listing {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  String? name;
  double? price;
  List? photos;
  double? ppsqm;
  double? floorArea;
  int? beds;
  int? baths;
  int? area;
  String? status;
  String? view;
  String? location;
  String? type;
  String? subCategory;
  String? by;
  String? owner;
  int? leads;
  int? views;
  DateTime? dateUpdated;
  DateTime? dateCreated;
  String? description;
  int? cars;
  bool? isSold;
  List? latLng;
  String? address;
  String? propertyId;
  Listing(
      {this.id,
      this.name,
      this.type,
      this.price,
      this.baths,
      this.photos,
      this.floorArea,
      this.location,
      this.status,
      this.area,
      this.beds,
      this.ppsqm,
      this.subCategory,
      this.view,
      this.description,
      this.by,
      this.dateUpdated,
      this.dateCreated,
      this.leads,
      this.owner,
      this.views,
      this.cars,
      this.isSold,
      this.latLng,
      this.propertyId,
      this.address});
  factory Listing.fromJSON(Map<String, dynamic> json) {
    return Listing(
        id: json["id"],
        name: json["name"] ?? "",
        price: json['price'].toString().toDouble(),
        type: json["type"] ?? "",
        baths: json["baths"] ?? 0,
        cars: json["garage"] ?? 0,
        photos: json["photos"] ?? [],
        floorArea: json["floor_area"].toString().toDouble(),
        location: json["location"],
        status: json["status"],
        area: json["area"],
        beds: json["beds"],
        view: json["view"],
        ppsqm: json["ppsqm"].toString().toDouble(),
        subCategory: json["sub_category"],
        by: json["by"],
        owner: json["owner"],
        leads: json["leads"],
        views: json["views"],
        propertyId: json['propertyId'] ?? "Invalid",
        dateCreated: (json["date_created"] == null)
            ? DateTime.now()
            : json["date_created"].runtimeType == Timestamp
                ? json["date_created"].toDate()
                : json["date_created"],
        dateUpdated: (json["date_updated"] == null)
            ? DateTime.now()
            : json["date_updated"].runtimeType == Timestamp
                ? json["date_updated"].toDate()
                : json["date_updated"],
        description: json["description"],
        isSold: json["is_sold"] ?? false,
        latLng: json['latLng'] ?? [0, 0],
        address: json['address'] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "photos": photos,
      "ppsqm": ppsqm,
      "floor_area": floorArea,
      "beds": beds,
      "baths": baths,
      "area": area,
      "status": status,
      "view": view,
      "location": location?.toLowerCase(),
      "type": type,
      "sub_category": subCategory,
      "leads": leads,
      "by": by,
      "owner": "admin", //todo change to owner field
      "description": description,
      "views": 0,
      "date_created": dateCreated ?? DateTime.now(),
      "date_updated": DateTime.now(),
      "garage": cars,
      "is_sold": isSold ?? false,
      "latLng": latLng ?? [0, 0],
      "address": address ?? "",
      "property_id" : propertyId
    };
  }

  getListing(id) async {
    return Listing.fromJSON(
        (await db.collection('listings').doc(id).get()).data() ?? {});
  }

  addListing(images, userId) async {
    photos = [];
    for (int i = 0; i < images!.length; i++) {
      if(kIsWeb){
        photos!.add(await CloudStorage()
            .uploadFromMemory(file: images![i], target: 'listings/$userId'));
      }else{
        photos!.add(await CloudStorage()
            .upload(file: images![i], target: 'listings/$userId'));
      }

    }
    DocumentReference<Map<String, dynamic>> doc =
        db.collection('listings').doc();
    await doc.set({
      "id": doc.id,
      "name": name,
      "price": price,
      "photos": photos,
      "ppsqm": ppsqm,
      "floor_area": floorArea,
      "beds": beds,
      "baths": baths,
      "area": area,
      "status": status,
      "view": view,
      "location": location,
      "type": type,
      "sub_category": subCategory,
      "landmarks": "",
      "leads": 0,
      "garage": cars,
      "by": user!.id,
      "owner": "admin",
      "amenities": "",
      "description": description,
      "views": 0,
      "date_created": DateTime.now(),
      "date_updated": DateTime.now(),
      "address": address ?? "",
      "latLng": latLng ?? [0, 0],
      "is_sold" : isSold ?? false
    });
  }

  updateListing() async {
    await db.collection("listings").doc(id).update(toMap());
  }

  deleteListings() async {
    try{
      await db.collection("listings").doc(id).delete();
    }catch(e){
      print(e);
    }
  }

  deleteListingsById(listingId) async {
    await db.collection("listings").doc(listingId).delete();
  }
  //todo build widgets
}