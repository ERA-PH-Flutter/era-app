// ignore_for_file: unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class AI{
  String query;
  String key = 'AIzaSyAGrHQ2vwgVgYB6bOP4QyQrRjdIaaGi1Sw';
  AI({
    required this.query
  });
  userSearch()async {
    var data = {
      "full_name": {
        "type": "string"
      },
      "location": {
        "type": "number"
      },
      "id": {
        "type": "string"
      }
    };
    var result = await geminiSearch(data,name: "userSearch");
    Query firebaseQuery = FirebaseFirestore.instance.collection('users');
    result!.forEach((key, value) {
      firebaseQuery = firebaseQuery.where(key,isGreaterThanOrEqualTo: value).where(key,isLessThanOrEqualTo: '$value\uf8ff');
    });
    return (await firebaseQuery.get()).docs;
  }
  projectSearch()async{
    Query firebaseQuery = FirebaseFirestore.instance.collection('projects');
    firebaseQuery = firebaseQuery.where('title',isGreaterThanOrEqualTo: query.capitalize).where('title',isLessThanOrEqualTo: '${query.capitalize}\uf8ff');
    return (await firebaseQuery.get()).docs;
  }
  listingSearch() async {
    var geminiData = {
      "type": {
        "type": "string",
        "enum": [
          "Apartment",
          "Condominium",
          "House and lot",
          "Townhouse",
          "Commercial",
          "Industrial",
          "Agricultural",
          "Land",
          "Foreclosed",
          "Pre selling",
          "Rent to own",
          "Others"
        ]
      },
      "sub_category": {
        "type": "string",
        "enum": [
          "Apartment",
          "House",
          "Lot",
          "Office",
          "Retail",
          "Warehouse",
          "Commercial",
          "Residential",
          "Condominium",
          "Townhouse",
          "Others"
        ]
      },
      "view": {
        "type": "string",
        "enum": [
          "sunset",
          "sunrise",
          "mountain",
          "beach",
          "city",
          "Others"
        ]
      },
      "amenities": {
        "type": "string"
      },
      "status": {
        "type": "string",
        "enum": ["sale", "rent", "Others"]
      },
      "location": {
        "type": "string"
      },
      "area": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "beds": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "baths": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "balcony": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "garage": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "price": {
        "type": "object",
        "properties": {
          "min": {"type": "number"},
          "max": {"type": "number"}
        }
      },
      "name": {
        "type": "string",
      }
    };
    var result = await geminiSearch(geminiData,name: "getListing",description: "Assign accordingly do not assign value if not specified");
    print(query);
    print(result);
    Query firebaseQuery = FirebaseFirestore.instance.collection('listings');
    List<AiFilters> prompts = [];
    result!.forEach((key, value) {
      if (['type', 'sub_category', 'view', 'status'].contains(key)) {
        if (value != "Others" &&
            query.toLowerCase().contains(value.toString().toLowerCase())) {
          var val = checkOperator(value);
          prompts.add(AiFilters(field: key, value: val[0]
              .toString()
              .capitalizeFirst, operator: val[1]));
        }
      } else {
        var val = checkOperator(value);
        prompts.add(AiFilters(field: key, value: val[0], operator: val[1]));
      }
    });
    for (int i = 0; i < (prompts.length); i++) {
      print(prompts[i].toMap());
      if (prompts[i].field == "name") {
        firebaseQuery = firebaseQuery.where('name', isGreaterThanOrEqualTo: prompts[i].value
            .toString()
            .capitalize)
            .where('name', isLessThanOrEqualTo: '${prompts[i].value
            .toString()
            .capitalize}\uf8ff');
        continue;
      }
      if (prompts[i].operator == ">") {
        firebaseQuery = firebaseQuery.where(
            prompts[i].field, isGreaterThanOrEqualTo: prompts[i].value);
        continue;
      }
      if (prompts[i].operator == "<") {
        firebaseQuery = firebaseQuery.where(
            prompts[i].field, isLessThanOrEqualTo: prompts[i].value);
        continue;
      }
      if (prompts[i].operator == "=") {
        firebaseQuery = firebaseQuery.where(prompts[i].field, isEqualTo: prompts[i].value);
        continue;
      }
    }
    var data = [];
    await firebaseQuery.get().then((QuerySnapshot snapshot) {
      var a = snapshot.docs;
      for (var b in a) {
        data.add(b.data());
      }
    });
    return data;
  }
  faqSearch()async{
    BaseController().showLoading();
    var data = {
      "question": {
        "type": "string"
      },
    };
    var result = await geminiSearch(data,name: "faqSearch",description:'use the prompt and parse it');
    Query firebaseQuery = FirebaseFirestore.instance.collection('faq');
    print(result);
    result!.forEach((key, value) {
      firebaseQuery = firebaseQuery.where(key,isGreaterThanOrEqualTo: value).where(key,isLessThanOrEqualTo: '$value\uf8ff').orderBy('type');
    });
    BaseController().hideLoading();
    return (await firebaseQuery.get()).docs;
  }

  checkOperator(value) {
    if ([String, int, bool].contains(value.runtimeType)) {
      return [value.toLowerCase(), "="];
    }
    if (value['min'] != null && value['max'] != null) {
      return [value['min'], "="];
    }
    if (value['min'] != null) {
      return [value['min'], "<"];
    }
    if (value['max'] != null) {
      return [value['max'], ">"];
    }
  }
  geminiSearch(data,{name='',description=''})async{
    Map<String, dynamic> body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": query}
          ]
        }
      ],
      "tools": [
        {
          "functionDeclarations": [
            {
              "name": name,
              "description": description,
              "parameters": {
                "type": "object",
                "properties": data
              }
            }
          ]
        }
      ],
      "toolConfig": {
        "functionCallingConfig": {"mode": "ANY"}
      },
      "generationConfig": {
        "temperature": 1,
        "topK": 64,
        "topP": 0.95,
        "maxOutputTokens": 8192,
        "responseMimeType": "text/plain"
      }
    };
    return (await GetConnect().post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$key',
        body,
        headers: {
          'Content-Type': 'application/json'
        }
    )).body['candidates'][0]['content']['parts'][0]['functionCall']['args'];
  }
}