import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ReRouteArgs{
  String name;
  Widget page;
  Bindings binding;
  List? arguments;
  String? id;
  ReRouteArgs({
    required this.name,
    required this.page,
    this.arguments,
    required this.binding,
    this.id
  });
}