import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/gridView_AllListings.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/listview_agent_allListings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/assets.dart';
import '../controllers/agent_listings_controller.dart';
import 'agentsDashBoard.dart';

class AgentListings extends GetView<AgentListingsController> {
  const AgentListings({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filter and sort row for the specific listing
            Obx(()=>switch(controller.agentListingsState.value){
              AgentListingsState.loading => _loading(),
              AgentListingsState.loaded => _loaded(),
              //AgentListingsState.empty => _loading(),
              AgentListingsState.error => _error(),
            })
          ],
        ),
      ),
    );
  }
  _loaded(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EraText(
                text: "LISTINGS",
                fontSize: EraTheme.header,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
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
          Row(
            children: [
              Image.network(
                '${controller.user.image == null || controller.user.image == "" ? AppStrings.noUserImageWhite : controller.user.image}',
                width: 100.w,
                height: 110.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AgentDashBoard.agentText(
                        '${controller.user.firstname} ${controller.user.lastname}',
                        AppColors.blue,
                        18.sp,
                        FontWeight.bold,
                        1.2),
                    AgentDashBoard.agentText('${controller.user.role ?? 'Agent'}',
                        AppColors.black, 12.sp, FontWeight.w400, 0.9),
                    AgentDashBoard.agentContact(
                        AppEraAssets.whatsappIcon, '${controller.user.whatsApp}'),
                    AgentDashBoard.agentContact(
                        AppEraAssets.emailIcon, '${controller.user.email}'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GridviewAlllistings(listingModels:controller.listings),
        ],
      ),
    );
  }
  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  _error() {
    return Center(
      child: EraText(
        text: "Something went Wrong!",
        color: Colors.black,
      ),
    );
  }
}