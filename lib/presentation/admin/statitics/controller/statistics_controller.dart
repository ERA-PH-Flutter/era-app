import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  var listings = RealEstateListing.listingsModels.obs;

  int get totalListings => listings.length;

  double get averagePrice {
    if (listings.isEmpty) return 0;
    return listings.fold(0, (sum, listing) => sum + listing.price) /
        listings.length;
  }

  int get totalLeads {
    return listings.fold(0, (sum, listing) => sum + listing.leads);
  }

  int get totalViews {
    return listings.fold(0, (sum, listing) => sum + listing.views);
  }

  double get averagePricePerSqm {
    if (listings.isEmpty) return 0;
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
