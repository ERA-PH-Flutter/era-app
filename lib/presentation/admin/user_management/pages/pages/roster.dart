import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';

import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Roster extends GetView<AgentAdminController> {
  const Roster({super.key});

  @override
  Widget build(BuildContext context) {
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
              text: 'AGENT CARD VIEW',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 10.h),
            EraText(
              text: 'FIND AGENT',
              color: AppColors.kRedColor,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.bold,
            ),
            buildField(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: Get.width - 520.w),
              child: Button(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                height: 35.h,
                text: 'SEARCH',
                fontSize: EraTheme.buttonFontSizeSmall,
                bgColor: AppColors.kRedColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            rosterGridview(listingModels: RealEstateListing.listingsModels),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget rosterGridview({required List<RealEstateListing> listingModels}) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 90.h,
        left: 10.w,
        right: 10.w,
      ),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 440.h,
          crossAxisCount: 3,
          crossAxisSpacing: 40.w,
          mainAxisSpacing: 30.h),
      itemCount: listingModels.length,
      itemBuilder: (context, i) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.hint.withOpacity(0.5), width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.hint.withOpacity(0.5),
              child: GestureDetector(
                onTap: () {},
                child: ListedBy(
                  text: '',
                  image: "${listingModels[i].user.image}",
                  agentFirstName: "${listingModels[i].user.firstname}",
                  agentLastName: "${listingModels[i].user.lastname}",
                  agentType: "${listingModels[i].user.role}",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: EraText(
                text: "Profile Overview",
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.w, top: 10.h, right: 25.w),
              child: EraText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non mauris congue, eleifend orci ac, eleifend est. Donec varius arcu magna, vel sagittis ex condimentum scelerisque. Fusce efficitur nisi ut mauris vulputate faucibus. Nullam hendrerit, lacus id interdum tempus.',
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    listingModels[i].user.whatsApp == null
                        ? AppEraAssets.whatsappIcon
                        : AppEraAssets.whatsappIcon,
                    width: 40.w,
                    height: 40.h,
                  ),
                  EraText(
                    text: "${listingModels[i].user.whatsApp}",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    lineHeight: 0.h,
                  ),
                ],
              ),
            ),
            sb10(),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    listingModels[i].user.email == null
                        ? AppEraAssets.emailIcon
                        : AppEraAssets.emailIcon,
                    width: 40.w,
                    height: 40.h,
                  ),
                  EraText(
                    text: "${listingModels[i].user.email}",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    lineHeight: 0.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250.w),
              child: Button(
                width: 150.w,
                height: 35.h,
                fontSize: EraTheme.buttonFontSizeSmall,
                text: 'MESSAGE',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField() {
    return Column(
      children: [
        buildFormField('First Name *', controller.fNameA, 'Last Name *',
            controller.lNameA),
        buildFormField('Phone Number *', controller.phoneNA, 'Email *',
            controller.emailAdressA),
      ],
    );
  }

  Widget buildFormField(String name, TextEditingController controller,
      String name2, TextEditingController controller2) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: name2,
                color: AppColors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: Get.width / 2.5,
                child: TextformfieldWidget(
                  controller: controller2,
                  fontSize: 12.sp,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
