class Settings{
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
  Settings({
    required this.appName,
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
    this.featuredAgents
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
      featuredAgents: json["featured_agents"] ?? []
    );
  }

}