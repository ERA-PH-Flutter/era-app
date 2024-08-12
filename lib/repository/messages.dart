import 'package:cloud_firestore/cloud_firestore.dart';

class Messages{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;

  Messages({
    required this.id,
  });

  factory Messages.fromJSON(Map<String, dynamic> json){
    return Messages(
        id: json['id']
    );
  }
  getMessages()async{
    return Messages.fromJSON((await db.collection('messages').doc(id).get()).data() ?? {});
  }
  addMessages()async{
    await db.collection('messages').add(
        toMap()
    );
  }
  updateMessages()async{
    await db.collection('messages').doc(id).update(toMap());
  }
  deleteMessages()async{
    await db.collection('messages').doc(id).delete();
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id,
    };
  }
}