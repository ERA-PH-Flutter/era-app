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
      height: 430.h,
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 430.w, //410
          crossAxisSpacing: 20.w,
        ),
        itemCount: companymodels.length,
        itemBuilder: (context, i) =>
            CompanyItems(companyItems: companymodels[i]),
      ),
    );
  }
}
