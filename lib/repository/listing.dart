import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';

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
  Listing({
    this.id,
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

  });
  factory Listing.fromJSON(Map<String, dynamic> json) {
    print(json);
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
      ppsqm: json["ppsqm"].toString().toDouble(),
      subCategory: json["sub_category"],
      by: json["by"],
      owner: json["owner"],
      leads: json["leads"],
      views: json["views"],
      dateCreated: (json["date_created"] == null
          ? DateTime.now()
          : json["date_created"].toDate()),
      dateUpdated: (json["date_updated"] == null
          ? DateTime.now()
          : json["date_created"].toDate()),
      description: json["description"],
      isSold: json["is_sold"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name?.toLowerCase(),
      "price": price,
      "photos": photos,
      "ppsqm": ppsqm,
      "floor_area": floorArea,
      "beds": beds,
      "baths": baths,
      "area": area,
      "status": status?.toLowerCase(),
      "view": view?.toLowerCase(),
      "location": location?.toLowerCase(),
      "type": type?.toLowerCase(),
      "sub_category": subCategory?.toLowerCase(),
      "leads": leads,
      "by": user!.id,
      "owner": "admin", //todo change to owner field
      "description": description?.toLowerCase(),
      "views": 0,
      "date_created": dateCreated ?? DateTime.now(),
      "date_updated" : DateTime.now(),
      "garage": cars,
      "is_sold": isSold ?? false,
    };
  }

  getListing(id) async {
    return Listing.fromJSON(
        (await db.collection('listings').doc(id).get()).data() ?? {});
  }

  addListing() async {
    /*
    landmarks
    amenities
    balcony,
    */
    var images = [];
    for (int i = 0; i < photos!.length; i++) {
      images.add(await CloudStorage().uploadImage(image: photos![i]));
    }
    DocumentReference<Map<String, dynamic>> doc =
        db.collection('listings').doc();
    await doc.set({
      "id": doc.id,
      "name": name,
      "price": price,
      "photos": images,
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
      "owner": "admin", //todo change to owner field
      "amenities": "",
      "description": "",
      "rooms": 0,
      "views": 0,
      "date_created": DateTime.now(),
    });
  }

  updateListing() async {
    //var images = [];
    /*
    for (int i = 0; i < photos!.length; i++) {
      images.add(await CloudStorage().uploadImage(image: photos![i]));
    }
    */
    await db.collection("listings").doc(id).update(toMap());
  }

  deleteListings() async {
    await db.collection("listings").doc(id).delete();
  }

  deleteListingsById(listingId) async {
    await db.collection("listings").doc(listingId).delete();
  }

  //todo build widgets
}
