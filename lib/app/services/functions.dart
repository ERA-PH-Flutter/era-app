import 'dart:math';
import 'dart:io';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../repository/listing.dart';
import '../models/listing_filters.dart';

class EraFunctions {
  static filter(List listings,List<ListingFilters> filters){
    var a = [];
    a = listings;
    return a.map(( listing){
      var legit = true;
      var listingMap = listing;
      for (var filter in filters) {
        if(filter.type == "number"){
          if(!(listingMap[filter.name] <= filter.valueMin && listingMap[filter.name] >= filter.valueMax)){
            legit = false;
          }
        }else{
          if(listingMap[filter.name] != filter.value){
            legit = false;
          }
        }
      }
      if(legit){
        return listing;
      }
    }).toList();
  }
  static urlToFile(url)async{
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    var response = await http.get(Uri.parse(await CloudStorage().getFileDirect(docRef: url)));
    return await file.writeAsBytes( response.bodyBytes);
  }
}