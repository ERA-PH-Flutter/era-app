import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;
  String? firstname;
  String? lastname;
  String? role;
  String? email;
  String? whatsApp;
  String? image;
  String? deviceId;
  String? lastLogin;
  String? status;
  User({
    required this.id,
    this.firstname,
    this.lastname,
    this.role,
    this.email,
    this.whatsApp,
    this.image,
    this.deviceId,
    this.lastLogin,
    this.status
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['role'],
      email: json['email'],
      whatsApp: json['whatsApp'],
      image: json['image'],
      deviceId: json['device_id'],
      lastLogin: json['last_login'],
      status: json['status']
    );
  }
  factory User.empty(){
    return User(
        id: "11",
        firstname: "",
        lastname: "",
        role: "user",
        email: "test@g.co",
        whatsApp: "0000-000-0900",
        image: ""
    );
  }
  getById(String id) async {
    return User.fromJSON((await db.collection('users').doc(id).get()).data() ?? {});
  }
  createUser()async{
    await db.collection('users').add(toMap());
  }
  updateUser()async{
    await db.collection('users').doc(id).update(toMap());
  }
  deleteUser()async{
    await db.collection('users').doc(id).delete();
  }
  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "role": role,
      "email": email,
      "whatsApp": whatsApp,
      "image": image,
      'status' : status,
      'last_login' : lastLogin,
      'device_id' : deviceId
    };
  }
}
