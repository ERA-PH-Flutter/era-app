import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/company_items.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyGridPage extends StatelessWidget {
  final List<CompanyModels> companymodels;
  const CompanyGridPage({
    super.key,
    required this.companymodels,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: PageScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 500, //410
      ),
      itemCount: companymodels.length,
      itemBuilder: (context, i) => CompanyItems(companyItems: companymodels[i]),
    );
  }
}