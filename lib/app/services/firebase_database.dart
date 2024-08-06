import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  FirebaseFirestore db = FirebaseFirestore.instance;
  Database();
  initialize()async{
    try{
      //todo convert to user equivalent
      return await db.collection("settings").doc('appSettings').get();
    }catch(error){
      return "Error: $error";
    }
  }
  getAllListing()async{
    try{
      //todo convert to user equivalent
      return await db.collection("listings").get();
    }catch(error){
      return "Error: $error";
    }
  }
  searchListingsByName(String name)async{
    try{
      //todo convert to user equivalent
      return await db.collection("listings").where("name",isEqualTo: name).get();
    }catch(error){
      return "Error: $error";
    }
  }
  getUserData(String id)async{
    try{
      //todo convert to user equivalent
      return await db.collection("users").doc(id).get();
    }catch(error){
      return "Error: $error";
    }
  }
  getAllProjects()async{
    try{
      //todo convert to user equivalent
      return await db.collection("projects").get();
    }catch(error){
      return "Error: $error";
    }
  }
  searchListing({
    location,
    type,
    price,
    property,
  })async
  {
    Query query = FirebaseFirestore.instance.collection('listings');
    var searchData = [];
    if(location != null || location == ""){
      query.where("location",isEqualTo: location);
    }
    if(type != null || location == ""){
      query.where("type",isEqualTo: type);
    }
    if(price != null || location == ""){
      query.where("price",isLessThanOrEqualTo: price);
    }
    if(property != null || location == ""){
      query.where("property",isEqualTo: property);
    }
    await query.get().then((snapshot){
      var a = snapshot.docs;
      a.forEach((b){
        searchData.add(b.data());
      });
    });
    return searchData;
  }
  addListing({
    name,
    price,
    photos,
    ppsqm,
    floorArea,
    beds,
    baths,
    area,
    status,
    view,
    location,
    type,
    subCategory,
  })async{
    /*
    landmarks
    leads
    garage
    by
    owner
    amenities
    description,
    rooms,
    balcony,
    views,
    date_created,
    */
    var images = [];
    for(int i = 0;i<photos.length;i++){
      images.add(await CloudStorage().uploadImage(image: photos[i]));
    }
    await db.collection("listings").add({
      "name" : name,
      "price" : int.parse(price), //eto example price pero string sinesend 
      "photos" : images,
      "ppsqm" : ppsqm,
      "floor_area" : floorArea,
      "beds" : beds,
      "baths" : baths,
      "area" : area,
      "status" : status,
      "view" : view,
      "location" : location,
      "type" : type,
      "sub_category" : subCategory,
      "landmarks" : "",
      "leads" : 0,
      "garage" : 0,
      "by" : FirebaseAuth.instance.currentUser!.uid,
      "owner" : "admin", //todo change to owner field
      "amenities" : "",
      "description" : "",
      "rooms" : 0,
      "views" : 0,
      "date_created" : DateTime.now(),
    });
    //todo add this listing to user
  }
}