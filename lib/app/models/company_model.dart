class CompanyNewsModel {
  final String image;
  final String title;
  final String description;

  CompanyNewsModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<CompanyNewsModel> companynews = [
    CompanyNewsModel(
        image: "assets/images/c1.jpg",
        title: "Company News",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    CompanyNewsModel(
        image: "assets/images/c2.jpg",
        title: "Company News",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
  ];
}
