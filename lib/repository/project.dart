import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id;

  Project({
    required this.id,
  });

  factory Project.fromJSON(Map<String, dynamic> json){
    return Project(
        id: json['id']
    );
  }
  getProject()async{
    return Project.fromJSON((await db.collection('project').doc(id).get()).data() ?? {});
  }
  addProject()async{
    await db.collection('projects').add(
        toMap()
    );
  }
  updateProject()async{
    await db.collection('projects').doc(id).update(toMap());
  }
  deleteProject()async{
    await db.collection('projects').doc(id).delete();
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id,
    };
  }
}