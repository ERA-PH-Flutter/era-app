import 'package:architecture/app/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class ImageAnimation extends StatelessWidget {
  bool isHover = false;
  Offset mousPos = new Offset(0, 0);
  ImageAnimation({super.key, required this.isHover, required this.mousPos});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// import 'package:architecture/app/constants/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hovering/hovering.dart';

// class ImageAnimation extends StatelessWidget {
//   final _key = GlobalKey<ScaffoldState>();

//   ImageAnimation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Hover Widget Demo',
//           // textScaler:
//         ),
//         HoverWidget(
//           hoverChild: Container(
//             height: 200,
//             width: 200,
//             color: AppColors.black,
//             child: Center(child: Text('Hover Me..')),
//           ),
//           onHover: (event) {
//             _key.currentState.showSnackBar(SnackBar(
//               content: Text('Yaay! I am Hovered'),
//             ));
//           },
//           child: Container(
//             height: 200,
//             width: 200,
//             color: Colors.red,
//             child: Center(child: Text('Hover Me..')),
//           ),
//         )
//       ],
//     );
//   }
// }
