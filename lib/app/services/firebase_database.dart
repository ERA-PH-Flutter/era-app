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
}