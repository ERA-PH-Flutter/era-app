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
      "assets/images/companynews1.jpg",
      "ERA PH LAUNCH",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      "assets/images/companynews3.jpg",
      "GROUND BREAKING",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      "assets/images/e1.JPG",
      "MEET THE TEAM",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
  ];
}
