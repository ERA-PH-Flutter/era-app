import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../repository/news.dart';

class ViewAllNews extends GetView<NewsController> {
  const ViewAllNews({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EraText(
                        text: 'Company News',
                        fontSize: EraTheme.header + 5.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kRedColor),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/companynews");
                      },
                      child: EraText(
                          text: 'See all',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                EraText(
                  text:
                      'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
                  fontSize: EraTheme.subHeader - 2.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.hint,
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: 550.h,
                  width: Get.width,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('news').snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 390.w, //410
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            News news = News.fromJSON(snapshot.data!.docs[i].data());
                            RxString selectedValue = "".obs;
                            return GestureDetector(
                            onTap: () {
                              // Get.offAll(() => CompanyNewsPage(
                              //     title: news.title,
                              //     image: news.image,
                              //     description: news.description));
                            },
                            child: Container(
                              width: Get.width,
                              margin: EdgeInsets.only(bottom: 15.h, right: 12.w),
                              child: Stack(
                                children: [
                                  CloudStorage().imageLoaderProvider(
                                    ref: news.image,
                                    height: 250.h,
                                    borderRadius: BorderRadius.circular(10.r)
                                  ),
                                  //todo missy add functionality to this
                                  Positioned(
                                    top: 5.h,
                                    right: 10.h,
                                    child: IconButton(
                                      onPressed: (){

                                      },
                                      icon: Icon(Icons.more_horiz_rounded,color: Colors.white,shadows: const [BoxShadow(offset: Offset(0,0),color:Colors.white,blurRadius: 5,spreadRadius: 1)],),
                                    )
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    left: -4.w,
                                    right: -4.w,
                                    top: 200.h,
                                    child: Card(
                                      color: AppColors.white,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            EraTheme.paddingWidthSmall + 15.w,
                                            vertical: 15.h),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            EraText(
                                              text: news.title ?? "No title",
                                              fontSize: EraTheme.paragraph + 5.sp,
                                              color: AppColors.kRedColor,
                                              fontWeight: FontWeight.bold,
                                              textOverflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                            EraText(
                                              text: news.description ?? "No description",
                                              fontSize: EraTheme.paragraph - 2.sp,
                                              color: AppColors.hint,
                                              fontWeight: FontWeight.w500,
                                              maxLines: 5,
                                              textOverflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          }
                        );
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
