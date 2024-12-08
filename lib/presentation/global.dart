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
  //"House and Lot",
  "House",
  "Lot",
  "Industrial Lot",
  "Office",
  "Parking Lot",
  //"Residential",
  "Resort",
  // "Townhouse",
  //"Warehouse",
  //"Penthouse",
  "Beach House",
  // "Loft",
  "School",
  //"Room",
  //"Memorial",
  /// "Coworking Space",
  // "Studio",
];

var propertyT = [
  'Pre-Selling',
  'Residential',
  'Commercial',
  'Rental',
  'Auction',
  // "House and Lot",
  // "Condominium",
  // "Townhouse",
  // "Commercial",
  // "Industrial",
  // "Agricultural",
  // "Land",
  // "Foreclosed",
  // "Pre-selling",
  // "Rent to Own",
  // "Others",
];
var newsArgument;
var listingArgument;