import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/listings_web_controller.dart';

class BuyWebListingPage extends GetView<ListingsWebController> {
  BuyWebListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.all(EraTheme.paddingWidthAdmin + 10.w),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listingArgument.toString()
                  )
                  // todo missy listing data ( use listingArgument )
                ],
              ),
            ),
          ],
        ),
      );
  }
}
