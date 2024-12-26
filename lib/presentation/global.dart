import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../app/models/settings.dart';
import '../repository/user.dart';

Settings? settings;
EraUser? user;
PageController pageViewController = PageController();
String? currentRoute = '/home';
var subCategory = [
  "Agricultural",
  "Apartment",
  "Commercial",
  "Condominium",
  "Factory",
  "Farm",
  "Hotel",
  "House",
  "Lot",
  "Industrial Lot",
  "Office",
  "Parking Lot",
  "Resort",
  "Beach House",
  "School",
];

var propertyT = [
  'Pre-Selling',
  'Residential',
  'Commercial',
  'Rental',
  'Auction',
];
var newsArgument;
var listingArgument;
var projectArgument;
var agentArgument;
var editListingArgument;
var idArgument;

setUser()async{
  if(user == null && FirebaseAuth.instance.currentUser != null){
    var firebaseUser = FirebaseAuth.instance.currentUser;
    user = await EraUser().getById(firebaseUser!.uid);
  }else if(user != null){
    // return user;
  }else{
    throw Exception('Error user not login!');
  }
}