  class RealEstateListing {
    final String image;
    final String type;
    final String description;
    final double price;
    final String bed;
    final String bath;
    final String area;
    final String car;
    final int beds;
    final int baths;
    final int areas;
    final int cars;
    final String listingBy;
    final String agentImage;
    final String agentName;
    final String agents;

    RealEstateListing(
        {required this.type,
        required this.image,
        required this.area,
        required this.bath,
        required this.bed,
        required this.car,
        required this.areas,
        required this.baths,
        required this.beds,
        required this.cars,
        required this.description,
        required this.price,
        required this.listingBy,
        required this.agentImage,
        required this.agentName,
        required this.agents});

    static List<RealEstateListing> listingsModels = [
      RealEstateListing(
          type: 'BGC Luxury Condo',
          image: 'assets/images/e1.JPG',
          area: 'assets/icons/plan.png',
          bath: 'assets/icons/tub.png',
          bed: 'assets/icons/bed.png',
          car: 'assets/icons/car.png',
          areas: 900,
          baths: 2,
          beds: 3,
          cars: 1,
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          price: 100000,
          listingBy: 'Era Philippines',
          agentImage: 'assets/images/e2.JPG',
          agentName: 'John Doe',
          agents: 'Agent/Broker'),
      RealEstateListing(
          type: 'House',
          image: 'assets/images/e3.JPG',
          area: 'assets/icons/plan.png',
          bath: 'assets/icons/tub.png',
          bed: 'assets/icons/bed.png',
          car: 'assets/icons/car.png',
          areas: 800,
          baths: 2,
          beds: 3,
          cars: 1,
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          price: 200000,
          listingBy: 'Era Philippines',
          agentImage: 'assets/images/e2.JPG',
          agentName: 'John Doe',
          agents: 'Agent/Broker'),
    ];
  }
