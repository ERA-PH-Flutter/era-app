class CompanyModels {
  final String image;
  final String title;
  final String description;

  CompanyModels(
    this.image,
    this.title,
    this.description,
  );

  static List<CompanyModels> companyNewsModels = [
    CompanyModels(
      "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/company-news%2Fcompanynews1.jpg?alt=media&token=a2fb062d-e753-43c8-b527-5968657e2dbe",
      "ERA PH LAUNCH",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/company-news%2Fcompanynews2.JPG?alt=media&token=e711f19a-2b0c-4624-a217-391fcd95ec5f",
      "GROUND BREAKING",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/company-news%2Fcompanynews3.jpg?alt=media&token=59839176-ca49-45da-bd42-e2bb662d5f5c",
      "MEET THE TEAM",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
  ];
}
