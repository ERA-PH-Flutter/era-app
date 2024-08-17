// import 'package:flutter/material.dart';

// class FilterOptions extends StatefulWidget {
//   final Function(String?, double?, double?, String?, String?) onFilterApplied;

//   FilterOptions({required this.onFilterApplied});

//   @override
//   _FilterOptionsState createState() => _FilterOptionsState();
// }

// class _FilterOptionsState extends State<FilterOptions> {
//   String? selectedCategory;
//   double? minPrice;
//   double? maxPrice;
//   String? selectedLocation;
//   String? selectedSpecificType;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         DropdownButton<String>(
//           hint: Text('Select Category'),
//           value: selectedCategory,
//           onChanged: (value) {
//             setState(() {
//               selectedCategory = value;
//             });
//           },
//           items: <String>['House', 'Apartment', 'Condo'] // Example categories
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Min Price'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) {
//             setState(() {
//               minPrice = double.tryParse(value);
//             });
//           },
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Max Price'),
//           keyboardType: TextInputType.number,
//           onChanged: (value) {
//             setState(() {
//               maxPrice = double.tryParse(value);
//             });
//           },
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Location'),
//           onChanged: (value) {
//             setState(() {
//               selectedLocation = value;
//             });
//           },
//         ),
//         TextField(
//           decoration: InputDecoration(labelText: 'Specific Type'),
//           onChanged: (value) {
//             setState(() {
//               selectedSpecificType = value;
//             });
//           },
//         ),
//         ElevatedButton(
//           onPressed: () {
//             widget.onFilterApplied(
//               selectedCategory,
//               minPrice,
//               maxPrice,
//               selectedLocation,
//               selectedSpecificType,
//             );
//           },
//           child: Text('Apply Filters'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               selectedCategory = null;
//               minPrice = null;
//               maxPrice = null;
//               selectedLocation = null;
//               selectedSpecificType = null;
//             });
//             widget.onFilterApplied(null, null, null, null, null);
//           },
//           child: Text('Clear Filters'),
//         ),
//       ],
//     );
//   }
// }
