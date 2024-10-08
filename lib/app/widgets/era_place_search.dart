import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/colors.dart';
import 'app_text.dart';

class EraPlaceSearch extends StatefulWidget {
  TextEditingController textFieldController;
  Function(LatLng coords)  callback;
  EraPlaceSearch({super.key,required this.textFieldController,required this.callback});

  @override
  State<EraPlaceSearch> createState() => _EraPlaceSearchState();
}

class _EraPlaceSearchState extends State<EraPlaceSearch> {
  int timer = 1;
  bool isReady = false;
  Timer? clock;
  int count = 0;
  var currentText = "".obs;
  RxList results = [].obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 53.h,
          child: Obx(()=>CupertinoTextField(
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.black,
                  width: 1.5.w
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            suffix: currentText.value != "" ? GestureDetector(
              onTap: (){
                widget.textFieldController.text = "";
                currentText.value = "";
                results.clear();
              },
              child: Container(
                height: Get.height,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.r),
                    topRight: Radius.circular(10.r)
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Icon(Icons.close,size: 25.sp,),
              ),
            ) : Container(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            placeholderStyle: GoogleFonts.lato(color: AppColors.hint, fontSize: 18.sp),
            placeholder: 'Search Location.',
            controller: widget.textFieldController,
            onChanged: (value)async{
              currentText.value = value;
              if(!isReady && clock == null){
                clock = Timer.periodic(Duration(milliseconds: 400), (t)async{
                  if(count  == timer){
                    clock!.cancel();
                    clock = null;
                    timer = 1;
                    var res = await GetConnect().get("https://api.eraphilippines.com/places.php?input=${widget.textFieldController.text}");
                    if(res.body != null){
                      var data = jsonDecode(res.body);
                      results.value = data['predictions'];
                    }
                    isReady = false;
                  }
                  timer++;
                }
                );
              }else{
                timer = 0;
              }

            },
          )),
        ),
        Obx((){
          if(results.value.isNotEmpty){
            return Container(
              constraints: BoxConstraints(
                maxHeight: kIsWeb ? 300.h : 200.h,
              ),
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: ()async{
                      var res =await GetConnect().get("https://api.eraphilippines.com/places.php?id=${results[index]['place_id']}");
                      var data = jsonDecode(res.body);
                      var coordinates = data['result']['geometry']['location'];
                      widget.textFieldController.text = results[index]['description'];
                      results.clear();
                      currentText.value = "";
                      widget.callback(LatLng(coordinates['lat'],coordinates['lng']));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: EraText(
                        text: results[index]['description'],
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            );
          }else if(currentText.value != ""){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: EraText(
                text: "No result found",
                color: Colors.black,
              ),
            );
          }else{
            return Container();
          }
        })
      ],
    );
  }
}
