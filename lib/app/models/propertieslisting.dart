class PropertiesModels {
  String image;
  String label;
  PropertiesModels({
    required this.image,
    required this.label,
  });

  static List<PropertiesModels> listings = [
    PropertiesModels(image: 'realEstate-differentTypesOfProperties/Pre-Selling.jpg', label: "PRE-SELLING"),
    PropertiesModels(image: 'realEstate-differentTypesOfProperties/Rental.jpg', label: "RESIDENTIAL"),
    PropertiesModels(image: 'realEstate-differentTypesOfProperties/Commercial.jpg', label: "COMMERCIAL"),
    PropertiesModels(image: 'realEstate-differentTypesOfProperties/Residential.jpg', label: "RENTAL"),
    PropertiesModels(image: 'realEstate-differentTypesOfProperties/Residential.jpg', label: "AUCTION"),
  ];
}