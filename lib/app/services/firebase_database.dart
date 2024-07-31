import 'package:cloud_firestore/cloud_firestore.dart';

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
  })async{
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

}