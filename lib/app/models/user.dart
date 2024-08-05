// ignore_for_file: unused_import

import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';

class User {
  String id;
  String? firstname;
  String? lastname;
  String? role;
  String? email;
  String? whatsApp;
  String? image;

  User(
      {required this.id,
      this.firstname,
      this.lastname,
      this.role,
      this.email,
      this.whatsApp,
      this.image});

  static getById(id) async {
    return await Database().getUserData(id);
  }

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['role'],
      email: json['email'],
      whatsApp: json['whatsApp'],
      image: json['image'],
    );
  }

  toJSON() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "role": role,
      "email": email,
      "whatsApp": whatsApp,
      "image": image,
    };
  }
}
