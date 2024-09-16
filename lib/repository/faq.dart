import 'package:cloud_firestore/cloud_firestore.dart';

class FAQ{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  String? question;
  String? answer;
  String? type;
  DateTime? dateCreated;

  FAQ({
    this.id,
    this.question,
    this.answer,
    this.type,
    this.dateCreated
  });

  factory FAQ.fromJSON(Map<String, dynamic> json){
    return FAQ(
      id: json['id'],
      question: json['question'] ?? "",
      answer: json['answer'] ?? "",
      type: json['type'] ?? "",
      dateCreated: json['date_created'].toDate()
    );
  }
  getFAQ()async{
    return FAQ.fromJSON((await db.collection('faq').doc(id).get()).data() ?? {});
  }
  addFAQ()async{
    var newFaq = db.collection('faq').doc();
    id = newFaq.id;
    await newFaq.set(toMap());
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
      'question': question,
      'answer': answer,
      'type': type,
      'date_created' : dateCreated ?? DateTime.now()
    };
  }
}