import 'package:cloud_firestore/cloud_firestore.dart';

class Logs {
  String? id;
  DateTime? dateCreated;
  String? title;
  String? type;

  Logs({
    this.id,
    this.dateCreated,
    this.title,
    this.type,
  });

  factory Logs.fromJson(Map<String, dynamic> json) {
    return Logs(
      dateCreated: DateTime.parse(json['date_created']),
      title: json['title'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_created': dateCreated ?? DateTime.now(),
      'title': title ?? "",
      'type': type ?? "account",
    };
  }

  Future<void> add() async {
    var logsDoc = FirebaseFirestore.instance.collection('logs').doc();
    id = logsDoc.id;
    await logsDoc.set(toJson());
  }

  Future<void> update() async {
    await FirebaseFirestore.instance.collection('myObjects').doc(id).update(toJson());
  }

  static Future<Logs?> getById(String id) async {
    final snapshot = await FirebaseFirestore.instance.collection('logs').doc(id).get();
    return snapshot.exists ? Logs.fromJson(snapshot.data()!) : null;
  }

  Future<void> delete() async {
    await FirebaseFirestore.instance.collection('logs').doc(id).delete();
  }
}