// ignore_for_file: unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/presentation/utility/controller/base_controller.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class AI{
  String query;
  final gemini = Gemini.instance;
  AI({
    required this.query
  });
  search(){
    String prompt = "write an mysql string text using this text search $query here are the available properties for mysql (location, type (apartment, condo, house, subdivision), status (pre selling, sold, selling, new, rent), size, rooms, baths, balcony, Amenities (gym or landmarks nearby), Garage View ( sunset, sunrise, mountain, beach, city etc.), price) dont use LIKE but use equals instead, give me mysql dont use new lines in generating answer don't add any other text";
    BaseController.showLoading();
    gemini.text(prompt)
      .then((value){
        process(value?.output);
        BaseController.hideLoading();
      }).catchError((e) => print(e));
  }
  process(results)async{
    results = results.split("WHERE")[1].replaceAll("'","").replaceAll(" ","").split("AND");
    await getProperties(results);
  }
  getProperties(List<String> filters) async {
    Query query = FirebaseFirestore.instance.collection('listings');
    var except = ["garage","baths","view","landmarks","name","owner","price","rooms","size","id","balcony","amenities"];
    var additionalFilters = [];
    for (final filter in filters) {

      if(filter.contains("<=")){
        var parts = filter.split("<=");
        final field = parts[0].toLowerCase();
        final value = parts[1];
        if(except.contains(field)){
          additionalFilters.add(AiFilters(
            field: field,
            value: value,
            operator: "<="
          ));
          continue;
        }
        query = query.where(field, isLessThanOrEqualTo: int.tryParse(value) ?? value);
      }else if(filter.contains(">=")){
        var parts = filter.split(">=");
        final field = parts[0].toLowerCase();
        final value = parts[1];
        if(except.contains(field)){
          additionalFilters.add(AiFilters(
              field: field,
              value: value,
              operator: ">="
          ));
          continue;
        }

        query = query.where(field, isGreaterThanOrEqualTo: int.tryParse(value) ?? value);
      }else if(filter.contains("=")){
        var parts = filter.split("=");
        final field = parts[0].toLowerCase();
        final value = parts[1];
        if(except.contains(field)){
          additionalFilters.add(AiFilters(
              field: field,
              value: value,
              operator: "="
          ));
          continue;
        }
        query = query.where(field, isEqualTo: int.tryParse(value) ?? value);
      }else if(filter.contains(">")){
        var parts = filter.split(">");
        final field = parts[0].toLowerCase();
        final value = parts[1];
        if(except.contains(field)){
          additionalFilters.add(AiFilters(
              field: field,
              value: value,
              operator: ">"
          ));
          continue;
        }
        query = query.where(field, isGreaterThan: int.tryParse(value) ?? value);
      }else if(filter.contains("<")){
        var parts = filter.split("<");
        final field = parts[0].toLowerCase();
        final value = parts[1];
        if(except.contains(field)){
          additionalFilters.add(AiFilters(
              field: field,
              value: value,
              operator: "<"
          ));
          continue;
        }
        query = query.where(field, isLessThan: int.tryParse(value) ?? value);
      }else{

      }
    }
    query.get().then((QuerySnapshot snapshot){
      var a = snapshot.docs;
      var ab = [];
      a.forEach((b){
       ab.add(b);
      });
      additionalFilters.forEach((af){
        ab.assignAll(af.operate(ab));
      });
      print(ab);
    });
  }
}