import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

class PlacesTextField extends StatelessWidget {
  var textController;
  LatLng? latLng;
  PlacesTextField({super.key,this.textController,this.latLng});

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      itemClick: (Prediction postalCodeResponse){
        // latLng = LatLng(postalCodeResponse.lat!.toDouble(), postalCodeResponse.lng!.toDouble());
        // print("${latLng!.latitude} ${latLng!.longitude}");
      },
      getPlaceDetailWithLatLng: (Prediction postalCodeResponse){
        textController.text = postalCodeResponse.description;
        latLng = LatLng(postalCodeResponse.lat!.toDouble(), postalCodeResponse.lng!.toDouble());
      },
      textEditingController: textController,
      googleAPIKey: AppStrings.googleMapKey,
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        hintText: 'Search Location.',
        hintStyle: TextStyle(color: AppColors.hint, fontSize: 18.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      debounceTime: 800,
      countries: const ["ph"],
      isLatLngRequired:true,
      isCrossBtnShown: true,
      placeType: PlaceType.geocode,

    );
  }
}
