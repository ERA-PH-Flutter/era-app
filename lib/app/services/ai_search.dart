// ignore_for_file: unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class AI{
  String query;
  final gemini = Gemini.instance;
  AI({
    required this.query
  });
  search()async{
    String prompt = "write an mysql string text using this text search ${query.toLowerCase()} here are the available properties for mysql (location, type (apartment, condo, house, subdivision) this is not required, status (pre selling, sold, selling, new, rent) this is not required, size, rooms, baths, balcony, Amenities (gym or landmarks nearby), Garage View ( sunset, sunrise, mountain, beach, city etc.), price) dont use LIKE but use equals instead also it is okay to be null if its not specified in the prompt if its null nevermind it make it simple, give me mysql do not use new lines in generating answer don't add any other text, no new lines, example: SELECT * FROM properties WHERE location = 'makati'";
    BaseController().showLoading();
    var toReturn;
    await gemini.text(prompt)
      .then((value)async{
        toReturn = await process(value?.output!);
        print(value?.output);
      }).catchError((e) => print(e));
    BaseController().hideLoading();
    return toReturn;
  }
  process(results)async{
    results = results.replaceAll('`', "");
    results = results.split("WHERE")[1].replaceAll("'","").replaceAll(" ","").split("AND");
    print(results);
    return await getProperties(results);
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
      }
      else if(filter.contains(">=")){
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
      }
      else if(filter.contains("=")){
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
      }
      else if(filter.contains(">")){
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
      }
      else if(filter.contains("<")){
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
      }
      else{

      }

    }
    var ab = [];
    await query.get().then((QuerySnapshot snapshot){
      var a = snapshot.docs;
      for (var b in a) {
       ab.add(b.data());
      }
      for (var af in additionalFilters) {
        ab.assignAll(af.operate(ab));
      }
    });
    return ab;
  }
}