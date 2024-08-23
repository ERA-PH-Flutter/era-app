import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/Listings/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../agents/controllers/agents_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<ListingsAdminController> {
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    //temporary
    AgentAdminController controllers = Get.put(AgentAdminController());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            EraText(
              text: 'PROPERTY INFORMATION',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 10.h,
            ),
            EraText(
              text: 'CREATE LISTING',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField2('Property Name *', controllers.fNameA,
                'Property Cost *', controllers.lNameA),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField4(
                'Price per sqm *',
                controllers.phoneNA,
                'Floor area *',
                controllers.positionA,
                'Rooms *',
                controllers.passwordA,
                'Bathrooms *',
                controllers.confirmPA),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField2('Location *', controllers.fNameA,
                'Property Type *', controllers.lNameA),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField4(
                'Offer Type *',
                controllers.phoneNA,
                'View *',
                controllers.positionA,
                'Sub Category *',
                controllers.passwordA,
                'Parking *',
                controllers.confirmPA),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFieldFormDesc(
                'Description *', controllers.descriptionA),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildUploadPhoto(),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  height: 35.h,
                  text: 'SUBMIT',
                  bgColor: AppColors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  height: 35.h,
                  text: 'CANCEL',
                  bgColor: AppColors.hint,
                  borderRadius: BorderRadius.circular(30),
                ),
              ]),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
