import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  List? data;
  DateTime? dateCreated;
  DateTime? dateUpdated;
  String? uploadedBy;
  Project({
    this.id,
    this.data,
    this.dateCreated,
    this.dateUpdated,
    this.uploadedBy,
  });

  factory Project.fromJSON(Map<String, dynamic> json){
    return Project(
      id: json['id'],
      data: json['data'],
      uploadedBy: json['uploaded_by'],
      dateCreated: (json["date_created"] == null)
          ? DateTime.now()
          : json["date_created"].runtimeType == Timestamp
          ? json["date_created"].toDate()
          : json["date_created"],
      dateUpdated: (json["date_updated"] == null)
          ? DateTime.now()
          : json["date_updated"].runtimeType == Timestamp
          ? json["date_updated"].toDate()
          : json["date_updated"],
    );
  }
  getProject()async{
    return Project.fromJSON((await db.collection('project').doc(id).get()).data() ?? {});
  }
  add()async{
    var projDocs = db.collection('projects').doc();
    id = projDocs.id;
    await projDocs.set(
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
      'data' : data,
      'date_created' : dateCreated ?? DateTime.now(),
      'date_updated' : DateTime.now(),
      'uploaded_by' : uploadedBy,
    };
  }
}