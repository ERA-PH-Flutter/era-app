import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  var searchFunction;
  SearchWidget({super.key,required this.searchFunction});
//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/icons%2FsearchIcon.png?alt=media&token=398319e2-5b95-48a2-9b4b-f453042dc1b4
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.kRedColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: GestureDetector(
        onTap: ()async{
          searchFunction;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/searchIcon.png',
              height: 34.h,
              width: 33.w,
            ),
            EraText(
              text: 'SEARCH',
              fontSize: 25.sp,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }
}
