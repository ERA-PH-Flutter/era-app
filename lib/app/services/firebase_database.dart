import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';

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
  //LISTING
  Future<List<Listing>> searchListingsByUserId(String id)async{
    return (await db.collection("listings").where('by',isEqualTo: id).get()).docs.map((data){
      return Listing.fromJSON(data.data());
    }).toList();
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
  getAllListing()async{
    try{
      //todo convert to user equivalent
      return await db.collection("listings").get();
    }catch(error){
      return "Error: $error";
    }
  }
  // USER
  getAllUser()async{
    return await db.collection('users').get();
  }
  searchUser({
    searchParam = "full_name",
    searchQuery
  })async{
    return (await db.collection('users').where(searchParam,isGreaterThanOrEqualTo: searchQuery).where(searchParam,isLessThanOrEqualTo: searchQuery + '\uf8ff').get()).docs.map((user){
      return EraUser.fromJSON(user.data());
    }).toList();
  }
  // PROJECTS
  getAllProjects()async{
    try{
      //todo convert to user equivalent
      return await db.collection("projects").get();
    }catch(error){
      return "Error: $error";
    }
  }
  // SETTINGS
  getSettings()async{
    return (await db.collection('settings').doc('main').get()).data();
  }
  // FAQ

  //CRUD NEWS

}