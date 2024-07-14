import 'package:architecture/app/models/company_model.dart';
import 'package:architecture/app/models/listing.dart';
import 'package:architecture/app/widgets/companynews_items.dart';
import 'package:architecture/app/widgets/listing_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CompanynewsBuilder extends StatelessWidget {
  final List<CompanyNewsModel> companymodels;

  const CompanynewsBuilder({super.key, required this.companymodels});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(20),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 410,
        ),
        itemCount: companymodels.length,
        itemBuilder: (context, i) => CompanyNewsItems(
          companynewsitems: companymodels[i],
        ),
      ),
    );
  }
}
