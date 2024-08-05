import 'package:eraphilippines/app/models/user.dart';

class RealEstateListing {
  final String image;
  final String type;
  final String description;
  final double price;
  final int beds;
  final int baths;
  final int areas;
  final int cars;
  final String listingBy;
  final User user;
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
      image: 'assets/images/carouselsliderpic5.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      price: 100000,
      listingBy: 'Era Philippines',
      user: User(
        id: '1',
        firstname: 'John',
        lastname: 'Doe',
        role: 'AGENT/BROKER',
        email: 'name@mail.com',
        whatsApp: '1234-123-1234',
        image: 'assets/images/agentpfp.png',
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
    RealEstateListing(
      type: 'BGC Luxury Condo',
      image: 'assets/images/carouselsliderpic5.jpg',
      areas: 900,
      baths: 2,
      beds: 3,
      cars: 1,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      price: 100000,
      listingBy: 'Era Philippines',
      user: User(
        id: '1',
        firstname: 'John',
        lastname: 'Doe',
        role: 'AGENT/BROKER',
        email: 'name@mail.com',
        whatsApp: '1234-123-1234',
        image: 'assets/images/agentpfp.png',
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
  factory RealEstateListing.fromJSON(Map<String, dynamic> json) {
    return RealEstateListing(
      type: json['type'],
      image: json['image'],
      areas: json['areas'],
      baths: json['baths'],
      beds: json['beds'],
      cars: json['cars'],
      description: json['description'],
      price: json['price'],
      listingBy: json['listingBy'],
      user: User.fromJSON(json['user']),
      listingId: json['listingId'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      addedDaysago: json['addedDaysago'],
      features: List<String>.from(json['features']),
      roomsAndInterior: List<String>.from(json['roomsAndInterior']),
      locationAndSchools: List<String>.from(json['locationAndSchools']),
      address: json['address'],
      propertyId: json['propertyId'],
      pricePerSqm: json['pricePerSqm'],
      offerType: json['offerType'],
      view: json['view'],
      location: json['location'],
      subCategory: json['subCategory'],
      views: json['views'],
      leads: json['leads'],
      specificType: json['specificType'],
    );
  }

  toJSON() {
    return {
      "type": type,
      "image": image,
      "areas": areas,
      "baths": baths,
      "beds": beds,
      "cars": cars,
      "description": description,
      "price": price,
      "listingBy": listingBy,
      "user": user.toJSON(),
      "listingId": listingId,
      "lastUpdated": lastUpdated.toIso8601String(),
      "addedDaysago": addedDaysago,
      "features": features,
      "roomsAndInterior": roomsAndInterior,
      "locationAndSchools": locationAndSchools,
      "address": address,
      "propertyId": propertyId,
      "pricePerSqm": pricePerSqm,
      "offerType": offerType,
      "view": view,
      "location": location,
      "subCategory": subCategory,
      "views": views,
      "leads": leads,
      "specificType": specificType,
    };
  }
}
