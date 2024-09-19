import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/sell_property/controller/sell_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/theme.dart';

class SellPropertyAdmin extends GetView<SellPropertyAController> {
  const SellPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    SellPropertyAController controller = Get.put(SellPropertyAController());
    return SingleChildScrollView(
      child: Container(
        //remove the fixed height since it's causing the overflow
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                EraText(
                  text: 'Sell Property Management',
                  color: AppColors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ExpansionTile(
              title: EraText(
                text: 'MANAGE SELL PROPERTY',
                color: AppColors.black,
              ),
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.addSellProperty();
                  },
                  child: EraText(
                    text: 'Add Sell Property',
                    color: AppColors.black,
                  ),
                ),
                sb10(),
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.sellProperty.length,
                    itemBuilder: (context, index) {
                      final property = controller.sellProperty[index];
                      return ExpansionTile(
                        title: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.sellPropertyRemove(index);
                                },
                                icon: Icon(Icons.delete)),
                            EraText(
                              text: 'Property ${index + 1}',
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        subtitle: EraText(
                            text: property['name'] ?? 'Unnamed Property'),
                        children: [
                          _builTextField('Phone: ${property['phone']}', 1),
                          _builTextField('Email: ${property['email']}', 1),
                          _builTextField(
                              'Property Type: ${property['propertyType']}', 1),
                          _builTextField(
                              'Location: ${property['propertyLocation']}', 1),
                          _builTextField('Price: ${property['price']}', 1),
                          _builTextField(
                              'Description: ${property['description']}', 10),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
            sb50(),
          ],
        ),
      ),
    );
  }

  Widget _builTextField(text, maxLines) {
    return ListTile(
      title: Expanded(
        child: EraText(
          text: text,
          maxLines: maxLines,
          color: AppColors.black,
        ),
      ),
    );
  }
}
