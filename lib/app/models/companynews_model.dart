class CompanyModels {
  final String image;
  final String title;
  final String description;

  CompanyModels({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<CompanyModels> companyNewsModels = [
    CompanyModels(
      image: "assets/images/companynews1.jpg",
      title: "ERA PH LAUNCH",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      image: "assets/images/companynews3.jpg",
      title: "GROUND BREAKING",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
    CompanyModels(
      image: "assets/images/e1.JPG",
      title: "MEET THE TEAM",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    ),
  ];
}
