class PropertyInfo {
  final String description;
  final int listingId;
  final DateTime lastUpdated;
  final int addedDaysago;
  final List<String> features;
  final List<String> roomsAndInterior;
  final List<String> locationAndSchools;
  final String address;
  final String propertyId;
  final String price;
  final String pricePerSqm;
  final int beds;
  final int baths;
  final double area;
  final String offerType;
  final String view;
  final String location;
  final String type;
  final String subCatergory;
  final int views;
  final int leads;

  PropertyInfo(
    this.description,
    this.listingId,
    this.lastUpdated,
    this.addedDaysago,
    this.features,
    this.roomsAndInterior,
    this.locationAndSchools,
    this.address,
    this.propertyId,
    this.price,
    this.pricePerSqm,
    this.beds,
    this.baths,
    this.area,
    this.offerType,
    this.view,
    this.location,
    this.type,
    this.subCatergory,
    this.views,
    this.leads,
  );

  var property = PropertyInfo(
    '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
    '12345',
    'Php 3,500,000',
    'Php 15,000',
    2,
    3,
    151,
    'Sale',
    'Riverside',
    'Bonifacio Global\nCity, Taguig',
    'Condominium',
    'Penthouse',
    100,
    30,
  );
}
