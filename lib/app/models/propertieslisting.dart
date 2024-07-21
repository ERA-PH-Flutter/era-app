class PropertiesListing {
  final String image;
  final String label;
  PropertiesListing({
    required this.image,
    required this.label,
  });

  static List<PropertiesListing> listings = [
    PropertiesListing(
        image: "assets/images/Pre-Selling.jpg", label: "PRE-SELLING"),
    PropertiesListing(
        image: "assets/images/Residential.jpg", label: "RESIDENTIAL"),
    PropertiesListing(
        image: "assets/images/Commercial.jpg", label: "COMMERCIAL"),
    PropertiesListing(image: "assets/images/Rental.jpg", label: "RENTAL"),
    PropertiesListing(image: "assets/images/Residential.jpg", label: "AUCTION"),
  ];
}

 
