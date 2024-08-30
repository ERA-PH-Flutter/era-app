// import 'package:eraphilippines/presentation/agent/add-edit_listings/controllers/searhmap_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // For jsonDecode

// class SearchLocationWidget extends GetView<SearchLocationController> {
//   const SearchLocationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SearchLocationController controller = Get.put(SearchLocationController());
//     final TextEditingController _textController = TextEditingController();
//     FocusNode _focusNode = FocusNode();

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Stack(
//         children: [
//           TextField(
//             controller: _textController,
//             focusNode: _focusNode,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'Enter location',
//               prefixIcon: Icon(Icons.search),
//             ),
//             onChanged: (value) {
//               controller.placeAutocomplete(value);
//             },
//           ),
//           Obx(() {
//             if (controller.places.isNotEmpty && _focusNode.hasFocus) {
//               return Positioned(
//                 left: 0,
//                 right: 0,
//                 top: 60, // Adjust as needed
//                 child: Material(
//                   elevation: 4.0,
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: controller.places.length,
//                     itemBuilder: (context, index) {
//                       final place = controller.places[index];
//                       return ListTile(
//                         title: Text(place['description'] ?? 'No description'),
//                         onTap: () {
//                           _textController.text = place['description'];
//                           controller.places.clear();
//                           _focusNode.unfocus(); // Close the suggestion list
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           }),
//         ],
//       ),
//     );
//   }
// }

// //   void placeAutocomplete(String query) async {
// //     Uri uri = Uri.https(
// //       "maps.googleapis.com",
// //       'maps/api/place/autocomplete/json',
// //       {
// //         "input": query,
// //         "key": apiKey,
// //       },
// //     );

// //     String? response = await NetworkUtility.fetchUrl(uri);

// //     if (response != null) {
// //       final jsonResponse = jsonDecode(response);
// //       setState(() {
// //         _places = jsonResponse['predictions'];
// //       });
// //     }
// //   }
// // }

// // class NetworkUtility {
// //   static Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
// //     try {
// //       final response = await http.get(uri, headers: headers);
// //       if (response.statusCode == 200) {
// //         return response.body;
// //       } else {
// //         return null;
// //       }
// //     } catch (e) {
// //       debugPrint(e.toString());
// //       return null;
// //     }
// //   }
// // }
