import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/company_grid.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CompanyNews extends GetView<HomeController> {
  const CompanyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompanyGrid(companymodels: CompanyModels.companyNewsModels),
      ],
    );
  }
}
