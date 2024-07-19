import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/company_items.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyGrid extends StatelessWidget {
  final List<CompanyModels> companymodels;
  const CompanyGrid({super.key, required this.companymodels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 430, //410
        ),
        itemCount: companymodels.length,
        itemBuilder: (context, i) =>
            CompanyItems(companyItems: companymodels[i]),
      ),
    );
  }
}
