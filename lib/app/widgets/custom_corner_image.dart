// import 'package:flutter/cupertino.dart';
// //todo: nikko small adjustments of the shape 

// class CustomCornerClipPath extends CustomClipper<Path> {
//   final double cornerR;
//   const CustomCornerClipPath({this.cornerR = 18.0});

// // just need adjustments for the desired shape
 
//   @override
//   Path getClip(Size size) => Path()
//     ..lineTo(size.width, 0)
//     ..lineTo(size.width, size.height)
//     ..lineTo(
//       150,
//       2590,
//     )
//     ..arcToPoint(
//       Offset(
//         0,
//         size.height - cornerR,
//       ),
//       radius: Radius.circular(cornerR),
//       clockwise: false,
//     );

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
