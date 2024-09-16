import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';

class Settings{
  String? settingsId;
  String appName;
  List? featuredListings;
  List? featuredProjects;
  List? banners;
  List? featuredNews;
  List? featuredAgents;
  int fileSizeLimit;
  bool isMaintenance;
  String? splashAd;
  String? residentialPicture;
  String? preSellingPicture;
  String? auctionPicture;
  String? commercialPicture;
  String? rentalPicture;
  double? exchangeRate;
  Settings({
    required this.appName,
    this.settingsId,
    this.featuredListings,
    this.featuredProjects,
    this.featuredNews,
    this.fileSizeLimit = 10,
    this.isMaintenance = false,
    required this.splashAd,
    this.preSellingPicture,
    this.residentialPicture,
    this.auctionPicture,
    this.commercialPicture,
    this.rentalPicture,
    this.banners,
    this.featuredAgents,
    this.exchangeRate
  });
  factory Settings.fromJSON(Map<String,dynamic> json){
    return Settings(
      appName: json['app_name'],
      featuredListings: json['featured_listings'] ?? [],
      featuredProjects: json['featured_projects'] ?? [],
      featuredNews: json['featured_news'] ?? [],
      fileSizeLimit: json['file_size'] ?? 10,
      isMaintenance: json['maintenance'] ?? false,
      splashAd: json['splash_ad'] ?? "",
      preSellingPicture: json['pre_selling_picture'] ?? "",
      residentialPicture: json['residential_picture'] ?? "",
      auctionPicture: json['auction_picture'] ?? "",
      commercialPicture: json['commercial_picture'] ?? "",
      rentalPicture: json['rental_picture'] ?? "",
      banners: json["banners"] ?? [],
      featuredAgents: json["featured_agents"] ?? [],
      exchangeRate: json["exchange_rate"] ?? 0,
      settingsId: json['id'],
    );
  }
  updatePicture(target,previousPicture,newPicture)async{
    await CloudStorage().deleteFileDirect(docRef: previousPicture);
    switch(target){
      case "residential":
        residentialPicture = await CloudStorage().uploadFromMemory(file: newPicture, target: 'settings',customName: "residential.png");
      case "rental":
        rentalPicture = await CloudStorage().uploadFromMemory(file: newPicture, target: 'settings',customName: "rental.png");
      case "commercial":
        commercialPicture = await CloudStorage().uploadFromMemory(file: newPicture, target: 'settings',customName: "commercial.png");
      case "pre-selling":
        preSellingPicture = await CloudStorage().uploadFromMemory(file: newPicture, target: 'settings',customName: "preSelling.png");
      default:
        auctionPicture = await CloudStorage().uploadFromMemory(file: newPicture, target: 'settings',customName: "auction.png");
    }
    await update();
  }
  deletePicture(target,previousPicture)async{
    await CloudStorage().deleteFileDirect(docRef: previousPicture);
    switch(target){
      case "residential":
        residentialPicture = null;
      case "rental":
        rentalPicture = null;
      case "commercial":
        commercialPicture = null;
      case "pre-selling":
        preSellingPicture = null;
      default:
        auctionPicture = null;
    }
    await update();
  }
  updateBanner(bannerImage)async{
    banners!.add(await CloudStorage().uploadFromMemory(file: bannerImage, target: 'banners',customName: "banner_${banners!.length}"));
    await update();
  }
  addToFeaturedListings(id)async{
    if(!featuredListings!.contains(id)){
      featuredListings!.add(id);
      await update();
    }else{
      featuredListings!.removeAt(featuredListings!.indexOf(id));
      await update();
    }
  }
  addToFeaturedNews(id)async{
    if(!featuredNews!.contains(id)){
      featuredNews!.add(id);
      await update();
    }else{
      featuredNews!.removeAt(featuredNews!.indexOf(id));
      await update();
    }
  }
  update()async{
    try{
      await FirebaseFirestore.instance.collection('settings').doc(settingsId).update(toMap());
    }catch(e){
      print(e);
    }
  }
  toMap(){
    return {
      'app_name': appName,
      'featured_listings': featuredListings,
      'featured_projects': featuredProjects,
      'featured_news': featuredNews,
      'file_size': fileSizeLimit,
      'maintenance': isMaintenance,
      'splash_ad': splashAd,
      'pre_selling_picture': preSellingPicture,
      'residential_picture': residentialPicture,
      'auction_picture': auctionPicture,
      'commercial_picture': commercialPicture,
      'rental_picture': rentalPicture,
      'banners': banners,
      'featured_agents': featuredAgents,
      'exchange_rate': exchangeRate,
      'id': settingsId,
    };
  }
}