import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  var listings = RealEstateListing.listingsModels.obs;
  int maxValue = 1;
  int get totalListings => listings.length;

  Future<int> calculateDifference(target)async{
    DateTime selectedDate = DateTime.now();
    final startOfWeek = selectedDate.subtract(Duration(days: 7));
    final endOfWeek = startOfWeek.subtract(Duration(days: 14));
    var res2Length;
    var query1 = FirebaseFirestore.instance.collection(target).where('date_created', isGreaterThanOrEqualTo: startOfWeek)
        .where('date_created', isLessThanOrEqualTo: selectedDate);
    var query2 = FirebaseFirestore.instance.collection(target).where('date_created', isGreaterThanOrEqualTo: endOfWeek)
        .where('date_created', isLessThanOrEqualTo: startOfWeek);
    if(target == "listings sold"){
      target = "listings";
      query1.where('is_sold', isEqualTo: true);
      query2.where('is_sold', isEqualTo: true);
    }
    var res1 = await query1.get();
    var res2 = await query2.get();
    res2Length = res2.docs.isEmpty ? 1 : res2.docs.length;
    return (((res1.docs.length) / res2Length) * 100).floor();
  }

  double get averagePrice {
    if (listings.isEmpty) return 0;
    // ignore: avoid_types_as_parameter_names
    return listings.fold(0, (sum, listing) => sum + listing.price) /
        listings.length;
  }

  int get totalLeads {
    // ignore: avoid_types_as_parameter_names
    return listings.fold(0, (sum, listing) => sum + listing.leads);
  }

  int get totalViews {
    // ignore: avoid_types_as_parameter_names
    return listings.fold(0, (sum, listing) => sum + listing.views);
  }

  double get averagePricePerSqm {
    if (listings.isEmpty) return 0;
    // ignore: avoid_types_as_parameter_names
    return listings.fold(0, (sum, listing) => sum + listing.pricePerSqm) /
        listings.length;
  }

  List<FlSpot> getPropertyPerformanceSpots() {
    return List.generate(listings.length, (index) {
      final listing = listings[index];
      return FlSpot(index.toDouble(), listing.price.toDouble());
    });
  }

  List<FlSpot> getLeadsPerformanceSpots() {
    return List.generate(listings.length, (index) {
      final listing = listings[index];
      return FlSpot(index.toDouble(), listing.leads.toDouble());
    });
  }

  List<FlSpot> getAgentPerformanceSpots() {
    final agentLeadsMap = <String, int>{};
    int agentIndex = 0;
    List<FlSpot> agentSpots = [];

    for (var listing in listings) {
      var agentName = '${listing.user.firstname} ${listing.user.lastname}';
      agentLeadsMap[agentName] =
          (agentLeadsMap[agentName] ?? 0) + listing.leads;
    }

    agentLeadsMap.forEach((agent, leads) {
      agentSpots.add(FlSpot(agentIndex.toDouble(), leads.toDouble()));
      agentIndex++;
    });

    return agentSpots;
  }

  Map<String, int> getAgentPerformanceChartData() {
    final agentLeadsMap = <String, int>{};

    for (var listing in listings) {
      var agentName = '${listing.user.firstname} ${listing.user.lastname}';
      agentLeadsMap[agentName] =
          (agentLeadsMap[agentName] ?? 0) + listing.leads;
    }

    return agentLeadsMap;
  }
}
