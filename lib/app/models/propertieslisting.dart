class PropertiesModels {
  String image;
  String label;
  PropertiesModels({
    required this.image,
    required this.label,
  });

  static List<PropertiesModels> listings = [
    PropertiesModels(
        image: 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FPre-Selling.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86', label: "PRE-SELLING"),
    PropertiesModels(
        image: 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FRental.jpg?alt=media&token=608a76e6-b8e0-4f2a-aab6-3926c3e9df10', label: "RESIDENTIAL"),
    PropertiesModels(
        image: 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FCommercial.jpg?alt=media&token=09a0175c-ef31-410a-950e-32d2ee71d789', label: "COMMERCIAL"),
    PropertiesModels(image: 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FResidential.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86', label: "RENTAL"),
    PropertiesModels(image: 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FResidential.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86', label: "AUCTION"),
  ];

//  CloudStorage().getfile(folder: 'realEstate-differentTypesOfProperties',listing.label.toLowerCase() + '.jpg');
}

// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FPre-Selling.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FRental.jpg?alt=media&token=608a76e6-b8e0-4f2a-aab6-3926c3e9df10
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FCommercial.jpg?alt=media&token=09a0175c-ef31-410a-950e-32d2ee71d789
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FResidential.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86
// https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/realEstate-differentTypesOfProperties%2FResidential.jpg?alt=media&token=c31fb6c6-f7d9-4f1d-98b5-9e63c1a32f86