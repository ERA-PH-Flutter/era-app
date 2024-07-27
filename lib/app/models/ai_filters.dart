import 'package:cloud_firestore/cloud_firestore.dart';

class AiFilters{
  String field;
  var value;
  String operator;
  AiFilters({
    required this.field,
    required this.value,
    required this.operator
  });
  operate(datas){
    List<QueryDocumentSnapshot> newData = [];
    datas.forEach((data){

      if(int.tryParse(value) != null){
        value = int.tryParse(value);
        if(operator == ">="){
          if(data[field] >= value){
            newData.add(data);
          }
        }else if(operator == "<="){
          if(data[field] <= value){
            newData.add(data);
          }
        }else if(operator == "="){
          if(data[field] == value){
            newData.add(data);
          }
        }else if(operator == ">"){
          if(data[field] > value){
            newData.add(data);
          }
        }else if(operator == "<"){
          if(data[field] < value){
            newData.add(data);
          }
        }
      }else{
        if(data[field] == value){
          newData.add(data);
        }
      }

    });
    return newData;
  }
}