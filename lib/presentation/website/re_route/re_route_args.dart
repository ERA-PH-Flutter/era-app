import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ReRouteArgs{
  Widget page;
  Bindings binding;
  List? arguments;
  ReRouteArgs({
    required this.page  ,
    required this.arguments,
    required this.binding,
  });
}