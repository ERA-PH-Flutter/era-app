import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;

  FAQ({
    required this.id,
  });

  factory FAQ.fromJSON(Map<String, dynamic> json){
    return FAQ(
        id: json['id']
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
      'id' : id,
    };
  }
}