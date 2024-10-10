import 'package:flutter/cupertino.dart';
import '../app/models/settings.dart';
import '../repository/user.dart';

Settings? settings;
EraUser? user;
PageController pageViewController = PageController();
String? currentRoute = '/home';
List? projectsData;