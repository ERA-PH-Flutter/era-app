import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/presentation/global.dart';

class EraUser {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  String? firstname;
  String? lastname;
  String? role;
  String? email;
  String? whatsApp;
  String? image;
  String? deviceId;
  String? lastLogin;
  String? status;
  String? eraId;
  int? age;
  String? gender;
  List? favorites;
  EraUser({
    this.id,
    this.firstname,
    this.lastname,
    this.role,
    this.email,
    this.whatsApp,
    this.image,
    this.deviceId,
    this.lastLogin,
    this.status,
    this.eraId,
    this.age,
    this.gender,
    this.favorites,
  });

  factory EraUser.fromJSON(Map<String, dynamic> json) {
    return EraUser(
      id: json['id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      role: json['role'],
      email: json['email'],
      whatsApp: json['whats_app'],
      image: json['image'],
      deviceId: json['device_id'],
      lastLogin: json['last_login'],
      status: json['status'],
      eraId: json['era_id'],
      age: json['age'],
      gender : json['gender'],
      favorites: json['favorites']
    );
  }
  factory EraUser.empty(){
    return EraUser(
        id: "11",
        firstname: "",
        lastname: "",
        role: "user",
        email: "test@g.co",
        whatsApp: "0000-000-0900",
        image: ""
    );
  }
  getById(targetId) async {
    return EraUser.fromJSON((await db.collection('users').doc(targetId).get()).data() ?? {});
  }
  add()async{
    id != null ? await db.collection('users').doc(id).set(toMap()) : await db.collection('users').add(toMap());
  }
  update()async{
    await db.collection('users').doc(id).update(toMap());
  }
  delete()async{
    await db.collection('users').doc(id).delete();
    //delete info too
  }
  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "first_name": firstname,
      "last_name": lastname,
      "role": role,
      "email": email,
      "whats_app": whatsApp,
      "image": image,
      'status' : status,
      'last_login' : lastLogin,
      'device_id' : deviceId,
      'era_id' : eraId ?? '',
      'age' : age ?? 0,
      'gender' : gender ?? 'male',
      'favorites' : favorites ?? []
    };
  }
}

class EraUserInfo{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  String? education;
  int? experience;
  String? pastTransaction;
  String? recruiter;
  String? specialization;
  String? status;
  String? transaction;
  EraUserInfo({
    this.education,
    this.id,
    this.experience,
    this.pastTransaction,
    this.recruiter,
    this.specialization,
    this.status,
    this.transaction
  });
  factory EraUserInfo.fromJson(json){
    return EraUserInfo(
      id: json['id'] ?? user!.id,
      education: json['education'],
      experience: json['experience'],
      pastTransaction: json['past_transaction'],
      recruiter: json['recruiter'],
      specialization: json['specialization'],
      status: json['status'],
      transaction: json['transaction'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id ?? (user != null ? user!.id : ''),
      'education' : education ?? '',
      'experience' : experience ?? 0,
      'past_transaction' : pastTransaction ?? 0,
      'recruiter' : recruiter ?? 'admin',
      'specialization' : specialization ?? 'Rental',
      'status' : status ?? 'No Licence',
      'transaction' : transaction ?? 0,
    };
  }
  getInfo()async{
    return (await db.collection('user_info').doc(id ?? user!.id).get()).data();
  }
  add()async{
    id != null ? await db.collection('user_info').doc(id).set(toMap()) : await db.collection('user_info').add(toMap());
  }
  update()async{
    await db.collection('user_info').doc(id ?? user!.id).update(toMap());
  }
  delete()async{
    await db.collection('user_info').doc(id ?? user!.id).delete();
  }
}