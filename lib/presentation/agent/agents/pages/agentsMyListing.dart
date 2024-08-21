import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/gridView_AllListings.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/listview_agent_allListings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentMyListing extends GetView<AgentsController> {
  AgentMyListing({super.key});

  @override
  Widget build(BuildContext context) {
    final RealEstateListing? listing = Get.arguments;

    if (listing == null) {
      return BaseScaffold(
        body: Center(child: Text("No listing data provided.")),
      );
    }

    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filter and sort row for the specific listing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: EraText(
                        text: 'MY LISTINGS',
                        fontSize: 30.sp,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    //TO DO: nikko not final this is for sorting
                    CustomSortPopup(
                      title: 'Sort by',
                      onSelected: (String result) {
                        print(result);
                      },
                      menuItems: const [
                        PopupMenuItem<String>(
                          value: 'Category',
                          child: Text('Category',
                              style: TextStyle(color: Colors.black)),
                        ),
                        PopupMenuItem<String>(
                          value: 'date_modified',
                          child: Text('Date',
                              style: TextStyle(color: Colors.black)),
                        ),
                        PopupMenuItem<String>(
                          value: 'Location',
                          child: Text('Location',
                              style: TextStyle(color: Colors.black)),
                        ),
                        PopupMenuItem<String>(
                          value: 'Amount',
                          child: Text('Amount',
                              style: TextStyle(color: Colors.black)),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem<String>(
                          value: 'ascending',
                          child: Text('Ascending'),
                        ),
                        PopupMenuItem<String>(
                          value: 'descending',
                          child: Text('Descending'),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListviewAgent(agentsModels: [listing]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GridviewAlllistings(listingModels: [listing]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
