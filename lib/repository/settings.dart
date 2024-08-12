import 'package:cloud_firestore/cloud_firestore.dart';

class Settings{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;

  Settings({
    required this.id,
  });

  factory Settings.fromJSON(Map<String, dynamic> json){
    return Settings(
        id: json['id']
    );
  }
  getSettings()async{
    return Settings.fromJSON((await db.collection('settings').doc(id).get()).data() ?? {});
  }
  addSettings()async{
    await db.collection('settings').add(
        toMap()
    );
  }
  updateSettings()async{
    await db.collection('settings').doc(id).update(toMap());
  }
  deleteSettings()async{
    await db.collection('settings').doc(id).delete();
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id,
    };
  }
}