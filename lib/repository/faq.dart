import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;
  String? title;
  String? description;
  String? type;

  FAQ({
    required this.id,
    this.title,
    this.description,
    this.type,
  });

  factory FAQ.fromJSON(Map<String, dynamic> json){
    return FAQ(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      type: json['type'] ?? "",
    );
  }
  getFAQ()async{
    return FAQ.fromJSON((await db.collection('faq').doc(id).get()).data() ?? {});
  }
  addFAQ()async{
    await db.collection('faq').add(
        toMap()
    );
  }
  updateFAQ()async{
    await db.collection('faq').doc(id).update(toMap());
  }
  deleteFAQ()async{
    await db.collection('faq').doc(id).delete();
  }
  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
    };
  }
}