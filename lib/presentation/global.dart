import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../app/models/settings.dart';
import '../repository/user.dart';

Settings? settings;
EraUser? user;

urlToFile(url)async{
  var rng = Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.png');
  var response = await http.get(Uri.parse(url));
  return await file.writeAsBytes( response.bodyBytes);
}