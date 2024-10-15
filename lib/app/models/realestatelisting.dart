import '../../repository/user.dart';

class RealEstateListing {
  final String image;
  final String type;
  final String description;
  final int price;
  final int beds;
  final int baths;
  final int areas;
  final int cars;
  final String listingBy;
  final EraUser user;
  final int listingId;
  final DateTime lastUpdated;
  final int addedDaysago;
  final List<String> features;
  final List<String> roomsAndInterior;
  final List<String> locationAndSchools;
  final String address;
  final int propertyId;
  final int pricePerSqm;
  final String offerType;
  final String view;
  final String location;
  final String subCategory;
  final int views;
  final int leads;
  final String specificType;

  RealEstateListing({
    required this.type,
    required this.image,
    required this.areas,
    required this.baths,
    required this.beds,
    required this.cars,
    required this.description,
    required this.price,
    required this.listingBy,
    required this.user,
    required this.listingId,
    required this.lastUpdated,
    required this.addedDaysago,
    required this.features,
    required this.roomsAndInterior,
    required this.locationAndSchools,
    required this.address,
    required this.propertyId,
    required this.pricePerSqm,
    required this.offerType,
    required this.view,
    required this.location,
    required this.subCategory,
    required this.views,
    required this.leads,
    required this.specificType,
  });

  static List<RealEstateListing> listingsModels = [
    RealEstateListing(
      type: 'BGC Luxury Condo',
      image:
          'listings/1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.sssLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum',
      price: 100000,
      listingBy: 'Era Philippines',
      user: EraUser(
        id: '1',
        firstname: 'John',
        lastname: 'Doe',
        role: 'Agent',
        email: 'name@mail.com',
        whatsApp: '1234-123-1234',
        image:
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/users%2Fimages%2FMIo72yQDoOcxHBhUYKNYjgEhcMb2.png?alt=media&token=5f903c0f-0669-4e64-87aa-2343d15d62a4',
      ),
      listingId: 24005341,
      lastUpdated: DateTime.parse('2024-06-26T08:02:00'),
      addedDaysago: 116,
      features: [
        'Fitness Center',
        '24 – Hour Security',
        'Landscaped Garden',
        'Swimming pool',
        'Basement Parking',
        'Gym',
        'Lounge',
        'Jogging path',
        'Parking lot'
      ],
      roomsAndInterior: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      locationAndSchools: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      address: '65 Calle Industria 1100,\nCubao Quezon City 6350718',
      propertyId: 12345,
      pricePerSqm: 15000,
      offerType: 'Sale',
      view: 'Riverside',
      location: 'Bonifacio Global\nCity, Taguig',
      subCategory: 'Penthouse',
      views: 100,
      leads: 1000,
      specificType: 'Condominium',
    ),
    RealEstateListing(
      type: 'Condominium',
      image:
          'listings/1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      price: 100000,
      listingBy: 'Era Philippines',
      user: EraUser(
        id: '1',
        firstname: 'John',
        lastname: 'Doe',
        role: 'Agent',
        email: 'name@mail.com',
        whatsApp: '1234-123-1234',
        image:
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/users%2Fimages%2FMIo72yQDoOcxHBhUYKNYjgEhcMb2.png?alt=media&token=5f903c0f-0669-4e64-87aa-2343d15d62a4',
      ),
      listingId: 24005341,
      lastUpdated: DateTime.parse('2024-06-26T08:02:00'),
      addedDaysago: 116,
      features: [
        'Fitness Center',
        '24 – Hour Security',
        'Landscaped Garden',
        'Swimming pool',
        'Basement Parking',
        'Gym',
        'Lounge',
        'Jogging path',
        'Parking lot'
      ],
      roomsAndInterior: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      locationAndSchools: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      address: '65 Calle Industria 1100,\nCubao Quezon City 6350718',
      propertyId: 12345,
      pricePerSqm: 15000,
      offerType: 'Sale',
      view: 'Riverside',
      location: 'Bonifacio Global\nCity, Taguig',
      subCategory: 'Penthouse',
      views: 100,
      leads: 2000,
      specificType: 'Condominium',
    ),
    RealEstateListing(
      type: 'The Procenium',
      image:
          'listings/1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      price: 100000,
      listingBy: 'Era Philippines',
      user: EraUser(
        id: '1',
        firstname: 'Maria',
        lastname: 'Doe',
        role: 'Agent',
        email: 'maria@mail.com',
        whatsApp: '1234-123-1234',
        image:
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/users%2Fimages%2FMIo72yQDoOcxHBhUYKNYjgEhcMb2.png?alt=media&token=5f903c0f-0669-4e64-87aa-2343d15d62a4',
      ),
      listingId: 24005341,
      lastUpdated: DateTime.parse('2024-06-26T08:02:00'),
      addedDaysago: 116,
      features: [
        'Fitness Center',
        '24 – Hour Security',
        'Landscaped Garden',
        'Swimming pool',
        'Basement Parking',
        'Gym',
        'Lounge',
        'Jogging path',
        'Parking lot'
      ],
      roomsAndInterior: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      locationAndSchools: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      address: '65 Calle Industria 1100,\nCubao Quezon City 6350718',
      propertyId: 12345,
      pricePerSqm: 15000,
      offerType: 'Sale',
      view: 'Riverside',
      location: 'Bonifacio Global\nCity, Taguig',
      subCategory: 'Penthouse',
      views: 100,
      leads: 53400,
      specificType: 'Condominium',
    ),
    RealEstateListing(
      type: 'BGC Luxury Condo',
      image:
          'listings/1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      price: 100000,
      listingBy: 'Era Philippines',
      user: EraUser(
        id: '1',
        firstname: 'Nicole',
        lastname: 'Doe',
        role: 'Broker',
        email: 'maria@mail.com',
        whatsApp: '1234-123-1234',
        image:
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/users%2Fimages%2FMIo72yQDoOcxHBhUYKNYjgEhcMb2.png?alt=media&token=5f903c0f-0669-4e64-87aa-2343d15d62a4',
      ),
      listingId: 24005341,
      lastUpdated: DateTime.parse('2024-06-26T08:02:00'),
      addedDaysago: 116,
      features: [
        'Fitness Center',
        '24 – Hour Security',
        'Landscaped Garden',
        'Swimming pool',
        'Basement Parking',
        'Gym',
        'Lounge',
        'Jogging path',
        'Parking lot'
      ],
      roomsAndInterior: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      locationAndSchools: [
        'Lorem ipsum dolor',
        'Sit amet consectetur',
        'Adipiscing elit, sed do'
      ],
      address: '65 Calle Industria 1100,\nCubao Quezon City 6350718',
      propertyId: 12345,
      pricePerSqm: 15000,
      offerType: 'Sale',
      view: 'Riverside',
      location: 'Bonifacio Global\nCity, Taguig',
      subCategory: 'Penthouse',
      views: 100,
      leads: 30,
      specificType: 'Condominium',
    ),
  ];
}
