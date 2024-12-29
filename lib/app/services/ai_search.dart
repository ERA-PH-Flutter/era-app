import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:get/get.dart';

class AI {
  String query;
  String key = 'AIzaSyAGrHQ2vwgVgYB6bOP4QyQrRjdIaaGi1Sw';
  AI({required this.query});
  userSearch() async {
    var data = {
      "full_name": {"type": "string"},
      "location": {"type": "number"},
      "id": {"type": "string"}
    };
    var result = await geminiSearch(data, name: "userSearch");

    print('gemini search user ${result }');
    Query firebaseQuery = FirebaseFirestore.instance.collection('users');
    result!.forEach((key, value) {
      firebaseQuery = firebaseQuery
          .where(key, isGreaterThanOrEqualTo: value)
          .where(key, isLessThanOrEqualTo: '$value\uf8ff');
    });
    return (await firebaseQuery.get()).docs;
  }

  Future<List<Project>> projectSearch() async {
    var geminiData = {
      "title": {
        "type": "string",
      },
      "developer_name": {
        "type": "string",
      },
      "location": {
        "type": "string",
      },
    };
    var result = await geminiSearch(geminiData,
            name: "getProject",
            description:
                "Assign accordingly do not assign value if not specified") ??
        [];

    try {
      HttpsCallable callable =
          FirebaseFunctions.instanceFor(region: 'asia-southeast1')
              .httpsCallable('projectQuery');
      final res = await callable.call({
        'searchQuery': [
          result.values.toList(),
          ...[query]
        ].join(',')
      });
      final data = (await FirebaseFirestore.instance
              .collection('projects')
              .orderBy('order_id')
              .get())
          .docs
          .map((e) => Project.fromJSON({...e.data(), 'id': e.id}));

      final projectIds = res.data ?? [];
      print('Error calling function: query $query');

      print('Error calling function: res.data ${res.data}');

      return data.where((e) => projectIds.contains(e.id)).toList();
    } catch (e, ex) {
      print(ex);
      print('Error calling function: $e');
      return [];
    }
  }

  Future<List<Listing>> listingSearch({
    List<AiFilters> overrideAiFilters = const [],
  }) async {
    try {
      print('gemini search overrideAiFilters 2 $overrideAiFilters');

      var geminiData = {
        "price": {
          "type": "object",
          "properties": {
            "min": {"type": "number"},
            "max": {"type": "number"}
          }
        },
        "type": {
          "type": "string",
          "enum": [
            "Pre-Selling",
            "Residential",
            "Commercial",
            "Rental",
            "Auction",
          ]
        },
        "sub_category": {
          "type": "string",
          "enum": [
            "Agricultural",
            "Apartment",
            "Commercial",
            "Condominium",
            "Factory",
            "Farm",
            "Hotel",
            "House",
            "Lot",
            "Industrial Lot",
            "Office",
            "Parking Lot",
            "Resort",
            "Beach House",
            "School",
          ]
        },
        "view": {
          "type": "string",
          "enum": [
            "sunset",
            "sunrise",
            "sea view",
            "mountain view",
            "beach",
            "city view",
            "Others"
          ]
        },
        "amenities": {"type": "string"},
        "status": {
          "type": "string",
          "enum": ["sale", "rent", "Others"]
        },
        "location": {"type": "string"},
        "baths": {
          "type": "object",
          "properties": {
            "equals": {"type": "number"},
          }
        },
        "balcony": {
          "type": "object",
          "properties": {
            "min": {"type": "number"},
            "max": {"type": "number"}
          }
        },
        "floor_area": {
          "type": "object",
          "properties": {
            "min": {"type": "number"},
            "max": {"type": "number"}
          }
        },
        "lot_area": {
          "type": "object",
          "properties": {
            "min": {"type": "number"},
            "max": {"type": "number"}
          }
        },
        "ppsqm": {
          "type": "object",
          "properties": {
            "min": {"type": "number"},
            "max": {"type": "number"}
          }
        },
        "garage": {
          "type": "object",
          "properties": {
            "equals": {"type": "number"},
          }
        },
        "name": {
          "type": "string",
        },
        "beds": {
          "type": "object",
          "properties": {
            "equals": {"type": "number"},
          }
        },
      };
      print('gemini search here 1 query $query');
      if (query.isEmpty && overrideAiFilters.isEmpty) {
        return (await FirebaseFirestore.instance.collection('listings').get())
            .docs
            .map((e) => Listing.fromJSON(e.data()))
            .toList();
      }
      var result = await geminiSearch(geminiData,
          name: "getListing",
          description:
              "Assign accordingly. Do not assign value if not specified.");

      print('gemini search here 1 result listing $result');

      Query<Map<String, dynamic>> firebaseQuery =
          FirebaseFirestore.instance.collection('listings');
      List<AiFilters> prompts = [];
      result!.forEach((key, value) {
        if (['type', 'sub_category', 'view', 'status'].contains(key)) {
          if (value != "Others" &&
              query.toLowerCase().contains(value.toString().toLowerCase())) {
            var val = checkOperator(value);
            prompts.add(AiFilters(
                field: key,
                value: val[0].toString().capitalizeFirst,
                operator: val[1]));
          }
        } else {
          List val = checkOperator(value);
          print('gemini search here 1 val val $val');

          for (int i = 0; i < val.length; i += 2) {
            prompts.add(
                AiFilters(field: key, value: val[i], operator: val[i + 1]));
          }
        }
      });
      // ai cannot be trusted
      print('gemini search overrideAiFilters $overrideAiFilters');
      for (var ov in overrideAiFilters) {
        if (!prompts
            .map((e) => '${e.field}/${e.operator}')
            .contains('${ov.field}/${ov.operator}')) {
          prompts.add(ov);
        }
      }
      Iterable<Listing> listingData = [];
      for (var element in prompts) {
        print(
            'gemini search result ${element.field} ${element.operator} ${element.value}');
      }
      try {
        listingData = (await firebaseQuery.get())
            .docs
            .map((e) => Listing.fromJSON({...e.data(), 'id': e.id}));
      } catch (e) {
        return [];
      }

      final Map<Listing, double> filteredData = {};
      for (var data in listingData) {
        double score = 0;
        bool minMatch = true;
        bool maxMatch = true;
        bool equalsMatch = true;
        for (int i = 0; i < (prompts.length); i++) {
          if (prompts[i].field == "name") {
            if (data
                .toMap()
                .toString()
                .toLowerCase()
                .contains(prompts[i].value.toString().toLowerCase())) {
              score++;
            }
            continue;
          }

          if (prompts[i].operator == ">") {
            score += .5;

            minMatch =
                ((data.toMap()[prompts[i].field] ?? 0) >= prompts[i].value);
            continue;
          }
          if (prompts[i].operator == "<") {
            score += .5;

            maxMatch =
                ((data.toMap()[prompts[i].field] ?? 0) <= prompts[i].value);
            continue;
          }
          if (prompts[i].operator == "=") {
            score++;
            equalsMatch =
                ((data.toMap()[prompts[i].field] ?? 0) == prompts[i].value);
            continue;
          }
        }
        final querySplit = query.split(' ').map((e) => e.toLowerCase());
        for (var split in querySplit) {
          if (geminiData.toString().contains(split)) continue;
          print('gemini search split $split');

          if (double.tryParse(split) == null) {
            if ((data
                .toMap()
                .toString()
                .toLowerCase()
                .contains(split.toLowerCase()))) {
              score = score + 0.3;
            }
          }
        }

        if (score >= 1 && (minMatch && maxMatch && equalsMatch)) {
          filteredData[data] = score;

          print('gemini search data ${data.name} ${score} ${data.beds}');
        }
      }

      var sortedEntries = filteredData.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      Map<Listing, double> sortedScores = {
        for (var entry in sortedEntries) entry.key: entry.value
      };

      return sortedScores.keys.toList();
    } catch (e) {
      print('gemini search error $e');
      return [];
    }
  }

  faqSearch() async {
    BaseController().showLoading();
    var data = {
      "question": {"type": "string"},
    };
    var result = await geminiSearch(data,
        name: "faqSearch", description: 'use the prompt and parse it');
    Query firebaseQuery = FirebaseFirestore.instance.collection('faq');
    result!.forEach((key, value) {
      firebaseQuery = firebaseQuery
          .where(key, isGreaterThanOrEqualTo: value)
          .where(key, isLessThanOrEqualTo: '$value\uf8ff')
          .orderBy('type');
    });
    BaseController().hideLoading();
    return (await firebaseQuery.get()).docs;
  }

  List checkOperator(value) {
    if ([String, int, bool].contains(value.runtimeType)) {
      return [value.toLowerCase(), "="];
    }
    if (value['min'] != null && value['max'] != null) {
      return [
        value['min'],
        ">",
        value['max'],
        "<",
      ];
    }
    if (value['min'] != null) {
      return [value['min'], ">"];
    }
    if (value['max'] != null) {
      return [value['max'], "<"];
    }
    if (value['equals'] != null) {
      return [value['equals'], "="];
    }
    return [];
  }

  geminiSearch(data, {name = '', description = ''}) async {
    Map<String, dynamic> body = {
      if (query.isNotEmpty) ...{
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": query}
            ]
          }
        ]
      },
      "tools": [
        {
          "functionDeclarations": [
            {
              "name": name,
              "description": description,
              "parameters": {"type": "object", "properties": data}
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
    final result = (await GetConnect().post(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$key',
            body,
            headers: {'Content-Type': 'application/json'}))
        .body['candidates']?[0]['content']?['parts']?[0]?['functionCall']?['args'];
    print('result gemini $result');
    return result ?? {};
  }
}
