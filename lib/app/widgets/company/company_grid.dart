import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/company/company_items.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyGrid extends StatelessWidget {
  final List<CompanyModels> companymodels;
  const CompanyGrid({
    super.key,
    required this.companymodels,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 400.h,
      child: GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 450, //410
        ),
        itemCount: companymodels.length,
        itemBuilder: (context, i) =>
            CompanyItems(companyItems: companymodels[i]),
      ),
    );
  }
}
