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
    String t1 = "write an mysql string text using this text search ${query.toLowerCase()} here are the available properties for mysql ";
    String t2 = " dont use LIKE but use equals instead also it is okay to be null if its not specified in the prompt if its null never mind it make it simple, give me mysql only, don't add any other text, no new lines, example: SELECT * FROM properties WHERE location = 'makati'";
    String type = "type (apartment, condominium, house and lot, townhouse, commercial, industrial, agricultural, land, foreclosed, pre_selling, rent_to_own, others) this is not required";
    String view = "view ( sunset, sunrise, mountain, beach, city etc.)";
    String subCategory = "sub_category (apartment, house, lot, office, retail, warehouse, commercial, residential, condominium, townhouse, others)";
    String amenities = "amenities (gym or landmarks nearby)";
    String status = "status (rent, sale) this is not required";
    String prompt = "$t1(location (if not complete please make it complete don not use space for example (makati, change it to makati,city), $type, $status, size, rooms, baths, balcony, $amenities, cars, $view, price, $subCategory)$t2";

    BaseController().showLoading();
    var toReturn;
    await gemini.text(prompt)
      .then((value)async{
        toReturn = await process(value?.output!);
        print(value?.output);
      }).catchError((e,ex) => print(ex));
    BaseController().hideLoading();
    return toReturn;
  }
  process(results)async{
    results = results.replaceAll('`', "");
    results = results.split("WHERE")[1].replaceAll("'","").replaceAll(" ","").replaceAll(',',' ').split("AND");
    return await getProperties(results);
  }
  getProperties(List<String> filters) async {
    Query query = FirebaseFirestore.instance.collection('listings');
    var except = ["cars","baths","view","name","owner","price","beds","size","id","balcony","amenities","area","by","description","floor_area","landmarks"];
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
    var ac = [];
    await query.get().then((QuerySnapshot snapshot){
      var a = snapshot.docs;

      for (var b in a) {
       ab.add(b.data());
      }

      for (var af in additionalFilters) {
        af.operate(ab) != null ? ac.add(af.operate(ab)) : null;
      }
      ac = additionalFilters.isEmpty ? ab : ac;
    });
    return ac;
  }
  calculateMortage({
    amount,downPayment, loanTerm, interest, monthly
  })async
  {
    var prompt = "Calculate mortgage given this data, property amount = $amount, down payment = $downPayment, loan term = $loanTerm, interest rate = $interest, monthly payment = $monthly, give me the value directly remove unnecessary explanation";
    BaseController().showLoading();
    var toReturn;
    await gemini.text(prompt)
        .then((value)async{
      toReturn = value?.output!;
      print(value?.output);
    }).catchError((e) => print(e));
    BaseController().hideLoading();
    return toReturn;
  }
}