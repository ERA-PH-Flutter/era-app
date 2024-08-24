import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../repository/user.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../widgets/app_text.dart';

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
          'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2F1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg?alt=media&token=873c7d4d-aa49-40fb-9e1b-c6715926b3e2',
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
      type: 'Condo',
      image:
          'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2F1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg?alt=media&token=873c7d4d-aa49-40fb-9e1b-c6715926b3e2',
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
      type: 'Makati Luxury Condo',
      image:
          'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2F1724412195589654_WhatsApp%20Image%202024-08-01%20at%2019.55.49_60aadad8.jpg?alt=media&token=873c7d4d-aa49-40fb-9e1b-c6715926b3e2',
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
        lastname: 'Duero',
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

  createMiniListing() {
    return GestureDetector(
      onTap: () {
        //Get.toNamed('/propertyInfo', arguments: listingsModels);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                width: 380.w,
                height: 200.h,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: type,
                fontSize: 16.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
                lineHeight: 0.4,
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppEraAssets.area,
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(width: 2.w),
                    EraText(
                      text: '$areas sqm',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.bed,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$beds',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.tub,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$baths',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.car,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$cars',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: 'Description:',
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                lineHeight: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                    .format(
                  price.toString() == "" ? 0 : price,
                ),
                color: AppColors.blue,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory RealEstateListing.fromJSON(Map<String, dynamic> json) {
    print(json['price']);
    return RealEstateListing(
      type: json['type'],
      image: json['image'] ?? "",
      areas: json['size'] ?? 0,
      baths: json['baths'] ?? 0,
      beds: json['beds'] ?? 0,
      cars: json['cars'] ?? 0,
      description: json['description'] ?? "Nothing added!",
      price: json['price'] ?? 0,
      listingBy: json['listingBy'] ?? "",
      user: EraUser.empty(),
      listingId: json['listingId'] ?? 0,
      lastUpdated: DateTime.parse(json['date_created'].toDate().toString()),
      addedDaysago: json['addedDaysago'] ?? 0,
      features: List<String>.from(json['features'] ?? []),
      roomsAndInterior: List<String>.from(json['roomsAndInterior'] ?? []),
      locationAndSchools: List<String>.from(json['locationAndSchools'] ?? []),
      address: json['address'] ?? "",
      propertyId: json['propertyId'] ?? 0,
      pricePerSqm: json['pricePerSqm'] ?? 0,
      offerType: json['offerType'] ?? "",
      view: json['view'] ?? "",
      location: json['location'] ?? "",
      subCategory: json['subCategory'] ?? "",
      views: json['views'] ?? 0,
      leads: json['leads'] ?? 0,
      specificType: json['specificType'] ?? "",
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
      "user": user.toMap(),
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
