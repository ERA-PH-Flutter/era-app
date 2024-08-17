import 'package:cloud_firestore/cloud_firestore.dart';

class News{
  FirebaseFirestore db = FirebaseFirestore.instance;
  String? id;
  String? image;
  String? title;
  String? description;
  News({
    this.id,
    this.image,
    this.description,
    this.title
  });

  factory News.fromJSON(Map<String, dynamic> json){
    return News(
      id: json['id'],
      image: json['image'],
      description: json['description'],
      title: json['title'],
    );
  }
  getNews()async{
    return News.fromJSON((await db.collection('news').doc(id).get()).data() ?? {});
  }
  addNews()async{
    await db.collection('news').add(
      toMap()
    );
  }
  updateNews()async{
    await db.collection('news').doc(id).update(toMap());
  }
  deleteNews()async{
    await db.collection('news').doc(id).delete();
  }
  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'image' : image,
      'description' : description
    };
  }
}