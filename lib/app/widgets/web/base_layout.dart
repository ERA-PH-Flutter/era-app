import 'package:eraphilippines/app/widgets/web/navbar.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;

  BaseLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Navbar(),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
