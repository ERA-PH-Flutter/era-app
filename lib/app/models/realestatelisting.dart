import 'package:eraphilippines/app/models/user.dart';
import 'package:intl/intl.dart';

class RealEstateListing{
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
  final String agentFirstName;
  final String agentLastName;
  final String agents;
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
  final String subCatergory;
  final int views;
  final int leads;
  final String convertusd;
  final String moneyIcon;
  final String sunriseIcon;
  final String specificType;
  final String whatsappIcon;
  final String whatsapp;
  final String emailIcon;

  final String email;

  RealEstateListing(
    this.type,
    this.image,
    this.area,
    this.bath,
    this.bed,
    this.car,
    this.areas,
    this.baths,
    this.beds,
    this.cars,
    this.description,
    this.price,
    this.listingBy,
    this.agentImage,
    this.agentFirstName,
    this.agentLastName,
    this.agents,
    this.listingId,
    this.lastUpdated,
    this.addedDaysago,
    this.features,
    this.roomsAndInterior,
    this.locationAndSchools,
    this.address,
    this.propertyId,
    this.pricePerSqm,
    this.offerType,
    this.view,
    this.location,
    this.subCatergory,
    this.views,
    this.leads,
    this.convertusd,
    this.moneyIcon,
    this.sunriseIcon,
    this.specificType,
    this.whatsappIcon,
    this.whatsapp,
    this.emailIcon,
    this.email,
  );

  static List<RealEstateListing> listingsModels = [
    RealEstateListing(
        'BGC Luxury Condo',
        'assets/images/carouselsliderpic5.jpg',
        'assets/icons/plan.png',
        'assets/icons/tub.png',
        'assets/icons/bed.png',
        'assets/icons/car.png',
        900,
        2,
        3,
        1,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        100000,
        'Era Philippines',
        'assets/images/agentpfp.png',
        'John',
        'Doe',
        'AGENT/BROKER',
        24005341,
        DateTime.parse('2024-06-26T08:02:00'),
        116,
        [
          '• Fitness Center',
          '• 24 – Hour Security',
          '• Landscaped Garden',
          '• Swimming pool',
          '• Basement Parking',
          '• Gym',
          '• Lounge',
          '• Jogging path',
          '• Parking lot'
        ],
        [
          '• Lorem ipsum dolor ',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        [
          '• Lorem ipsum dolor',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        '65 Calle Industria 1100,\nCubao Quezon City 6350718',
        12345,
        15000,
        'Sale',
        'Riverside',
        'Bonifacio Global\nCity, Taguig',
        'Penthouse',
        100,
        30,
        'assets/icons/convertusd.png',
        'assets/icons/money2.png',
        'assets/icons/sunrise.png',
        'Condominium',
        "assets/icons/whatsapp.png",
        "1234-123-1234",
        "assets/icons/mail.png",
        "name@mail.com"),
    RealEstateListing(
        'Condo in Makati',
        'assets/images/listingexample3.png',
        'assets/icons/plan.png',
        'assets/icons/tub.png',
        'assets/icons/bed.png',
        'assets/icons/car.png',
        800,
        2,
        3,
        1,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        200000,
        'Era Philippines',
        'assets/images/agentpfp.png',
        'Allson',
        'Smith',
        'AGENT/BROKER',
        24005341,
        DateTime.parse('2024-06-26T08:02:00'),
        116,
        [
          '• Fitness Center',
          '• 24 – Hour Security',
          '• Landscaped Garden',
          '• Swimming pool',
          '• Basement Parking',
          '• Gym',
          '• Lounge',
          '• Jogging path',
          '• Parking lot'
        ],
        [
          '• Lorem ipsum dolor ',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        [
          '• Lorem ipsum dolor',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        '65 Calle Industria 1100,\nCubao Quezon City 6350718',
        12345,
        15000,
        'Sale',
        'Riverside',
        'Bonifacio Global\nCity, Taguig',
        'Penthouse',
        100,
        30,
        'assets/icons/convertusd.png',
        'assets/icons/money2.png',
        'assets/icons/sunrise.png',
        'Condominium',
        "assets/icons/whatsapp.png",
        "1234-123-1234",
        "assets/icons/mail.png",
        "name@mail.com"),
    RealEstateListing(
        'Mansion in Laguna',
        'assets/images/listingexample3.png',
        'assets/icons/plan.png',
        'assets/icons/tub.png',
        'assets/icons/bed.png',
        'assets/icons/car.png',
        800,
        2,
        3,
        1,
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        200000,
        'Era Philippines',
        'assets/images/agentpfp.png',
        'Mark',
        'Williams',
        'AGENT/BROKER',
        24005341,
        DateTime.parse('2024-06-26T08:02:00'),
        116,
        [
          '• Fitness Center',
          '• 24 – Hour Security',
          '• Landscaped Garden',
          '• Swimming pool',
          '• Basement Parking',
          '• Gym',
          '• Lounge',
          '• Jogging path',
          '• Parking lot'
        ],
        [
          '• Lorem ipsum dolor ',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        [
          '• Lorem ipsum dolor',
          '• Sit amet consectetur',
          '• Adipiscing elit, sed do'
        ],
        '65 Calle Industria 1100,\nCubao Quezon City 6350718',
        12345,
        15000,
        'Sale',
        'Riverside',
        'Bonifacio Global\nCity, Taguig',
        'Penthouse',
        100,
        30,
        'assets/icons/convertusd.png',
        'assets/icons/money2.png',
        'assets/icons/sunrise.png',
        'Condominium',
        "assets/icons/whatsapp.png",
        "1234-123-1234",
        "assets/icons/mail.png",
        "name@mail.com"),
  ];
}
