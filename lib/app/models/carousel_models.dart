class CarouselModels {
  final String image;
  final String image1;
  final String image2;
  final String image3;

  CarouselModels({
    required this.image,
    required this.image1,
    required this.image2,
    required this.image3,
  });

  static List<CarouselModels> carouselModels = [
    CarouselModels(
      image: "assets/images/carouselsliderpic2.jpg",
      image1: "assets/images/carouselsliderpic3.jpg",
      image2: "assets/images/carouselsliderpic4.jpg",
      image3: "assets/images/carouselsliderpic5.jpg",
    ),
  ];
  static List<CarouselModels> carouselModels2 = [
    CarouselModels(
      image: "assets/images/slider_haraya-project.jpg",
      image1: "assets/images/slider_haraya-project2.jpg",
      image2: "assets/images/slider_haraya-project3.jpg",
      image3: "assets/images/slider_haraya-project4",
    ),
  ];
}
