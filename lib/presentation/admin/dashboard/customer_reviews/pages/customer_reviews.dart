import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: EraText(
        text: 'Customer Reviews',
        color: AppColors.kRedColor,
      ),
    );
  }
}
