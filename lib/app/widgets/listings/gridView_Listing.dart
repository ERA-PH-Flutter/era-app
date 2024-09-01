import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../services/firebase_database.dart';

//todo: nikko i want you to check why when i click tap the property info it is not working when im in property info page but in homepage it is working.
class ListingProperties extends StatelessWidget {
  final List<Listing> listingModels;

  const ListingProperties({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {

    if(listingModels.isNotEmpty){
      return Container(
        height: 500.h,
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 410,
            ),
            itemCount: listingModels.length,
            itemBuilder: (context, i){
              return FutureBuilder(
                future: EraUser().getById(listingModels[i].by) ,
                builder: (context,AsyncSnapshot<EraUser> snapshot){
                  if(snapshot.hasData){
                    return ListingItemss(
                      fromSold: false,
                      image: (listingModels[i].photos!.isEmpty ?  AppStrings.noImageWhite : listingModels[i].photos!.first != "" ?  listingModels[i].photos!.first :AppStrings.noImageWhite ),
                      type: listingModels[i].type ?? 'pre-selling',
                      areas: listingModels[i].area ?? 0,
                      beds: listingModels[i].beds ?? 0,
                      baths: listingModels[i].baths ?? 0,
                      cars: listingModels[i].cars ?? 0,
                      description: listingModels[i].description ?? '',
                      price: listingModels[i].price ?? 0,
                      showListedby: true,
                      agentImage: snapshot.data!.image.toString().notEmpty(AppStrings.noUserImageWhite),
                      agentFirstName: '${snapshot.data!.firstname}',
                      agentLastName: '${snapshot.data!.lastname}',
                      role: '${snapshot.data!.role}',
                      onTap: ()async{
                        await Database().addViews(listingModels[i].id);
                        Get.toNamed('/propertyInfo', arguments: listingModels[i],);
                      },
                      isSold: false,
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }
        ),
      );
    }else{
      return Column(
        children: [
          Container(
            height: 100.h,
            child: Center(
              child: EraText(
                text: "No Featured Listing.",
                color: Colors.black,
                fontSize: EraTheme.subHeader,
              ),
            ),
          ),
          SizedBox(height: 25.h,)
        ],
      );
    }

  }
}
