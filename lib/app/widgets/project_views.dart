import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/project_view_binding.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../constants/theme.dart';
import 'app_text.dart';

class ProjectViews {
  Project project;
  ProjectViews({required this.project});
  build() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: project.data!.length,
      itemBuilder: (context, index) {
        var data = project.data![index];
        if (data['type'] == "Banner Images") {
          return CloudStorage().imageLoaderProvider(
            ref: data['image'],
            height: 250.h,
            width: Get.width,
          );
        } else if (data['type'] == "Developer Name") {
          return EraText(
            textAlign: TextAlign.center,
            text: data['developer_name'],
            color: AppColors.hint,
            fontSize: EraTheme.small,
          );
        } else if (data['type'] == "Project Logo") {
          return CloudStorage().imageLoaderProvider(
            ref: data['image'],
            height: 150.h,
            width: 241.h,
          );
        } else if (data['type'] == "3D Virtual") {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            color: AppColors.hint.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(
                  text: data['title'],
                  textAlign: TextAlign.start,
                ),
                sb20(),
                description(text: data['description']),
              ],
            ),
          );
        } else if (data['type'] == "Blurb") {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(
                  padding: EdgeInsets.zero,
                  text: data['title'],
                ),
                sb30(),
                CloudStorage().imageLoaderProvider(
                  ref: data['image'],
                  height: 250.h,
                  width: Get.width,
                ),
                sb20(),
                description(text: data['description']),
              ],
            ),
          );
        } else if (data['type'] == "Location") {
          return Container(
            height: 350.h,
            width: Get.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(data['location'][0], data['location'][1]),
                  zoom: 15),
              markers: {
                Marker(
                    position: LatLng(data['location'][0], data['location'][1]),
                    markerId: MarkerId('mainPin'),
                    icon: BitmapDescriptor.defaultMarker)
              },
              zoomControlsEnabled: false,
            ),
          );
        } else if (data['type'] == "Outdoor Amenities") {
          if (data['sub_type'] == 'blurb') {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(
                    padding: EdgeInsets.zero,
                    text: data['title'],
                  ),
                  sb30(),
                  CloudStorage().imageLoaderProvider(
                    ref: data['image'],
                    height: 250.h,
                    width: Get.width,
                  ),
                  sb20(),
                  description(text: data['description']),
                ],
              ),
            );
          } else if (data['sub_type'] == 'gallery') {
            //im getting erorr here if i use getx :<
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              height: 350.h,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: Get.width,
                      height: 320.h,
                      child: CloudStorage().imageLoaderProvider(
                        ref: data['images'][0],
                        height: 250.h,
                        width: Get.width,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      height: 70.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data['images'].length,
                        itemBuilder: (context, index) {
                          var currentImage;
                          final isSelected =
                              currentImage == data['images'][index];
                          return GestureDetector(
                            onTap: () {
                              currentImage.value = data['images'][index];
                            },
                            child: Container(
                                decoration: isSelected
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.hint,
                                          width: 5.w,
                                        ),
                                      )
                                    : BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.hint,
                                          width: 2.w,
                                        ),
                                      ),
                                child: CloudStorage().imageLoaderProvider(
                                  ref: data['images'][index],
                                  width: 70.w,
                                  height: Get.height,
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else if (data['type'] == "Indoor Amenities") {
          if (data['sub_type'] == 'blurb') {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(
                    padding: EdgeInsets.zero,
                    text: data['title'],
                  ),
                  sb30(),
                  CloudStorage().imageLoaderProvider(
                    ref: data['image'],
                    height: 250.h,
                    width: Get.width,
                  ),
                  sb20(),
                  description(text: data['description']),
                ],
              ),
            );
          } else if (data['sub_type'] == 'gallery') {
            return SizedBox(
              height: 350.h,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: Get.width,
                      height: 320.h,
                      child: CloudStorage().imageLoaderProvider(
                        ref: data['images'][0],
                        height: 250.h,
                        width: Get.width,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      height: 70.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data['images'].length,
                        itemBuilder: (context, index) {
                          var currentImage;
                          final isSelected =
                              currentImage == data['images'][index];
                          return GestureDetector(
                            onTap: () {
                              currentImage.value = data['images'][index];
                            },
                            child: Container(
                              decoration: isSelected
                                  ? BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.hint,
                                        width: 5.w,
                                      ),
                                    )
                                  : BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.hint,
                                        width: 2.w,
                                      ),
                                    ),
                              child: CloudStorage().imageLoaderProvider(
                                ref: data['images'][index],
                                height: 250.h,
                                width: Get.width,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else if (data['type'] == "Carousel") {
          return Container(
            color: AppColors.hint.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb20(),
                title(
                  text: data['title'],
                  textAlign: TextAlign.start,
                ),
                sb10(),
                Container(
                    padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                    child: CarouselSlider(
                      items: data['images'].map<Widget>((image) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CloudStorage().imageLoader(
                            ref: image,
                            width: Get.width,
                            height: Get.height,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        enlargeFactor: 0.4,
                        // enableInfiniteScroll: true,103099Seb
                        viewportFraction: 0.7,
                        aspectRatio: 1.9,
                      ),
                    )),
                sb20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    infoTilePreview(
                        AppEraAssets.floorArea,
                        TextEditingController(
                            text: data['floor_area'].toString()),
                        ' sqm',
                        (value) {}),
                    infoTilePreview(
                        AppEraAssets.numberOfBed,
                        TextEditingController(text: data['beds'].toString()),
                        '',
                        (value) {}),
                    infoTilePreview(
                        AppEraAssets.loggiaSize,
                        TextEditingController(
                            text: data['loggia_size'].toString()),
                        ' sqm',
                        (value) {}),
                  ],
                ),
                sb20(),
                description(
                  text: data['paragraph'],
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth30),
                ),
              ],
            ),
          );
        } else if (data['type'] == "Space") {
          return SizedBox(height: data['height'].toString().toDouble());
        }
        return Container();
      },
    );
  }

  buildPreview() {
    List<Widget> preview = [
      Container(),
      Container(),
      Container(),
      sb50(),
    ];
    for (var block in project.data!) {
      if (block['type'] == "Developer Name") {
        preview[1] = Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: EraText(
            textAlign: TextAlign.center,
            text: block['developer_name'],
            color: AppColors.hint,
            fontSize: EraTheme.small,
          ),
        );
      }
      if (block['type'] == "Project Logo") {
        preview[2] = CloudStorage().imageLoaderProvider(
          ref: block['image'],
          height: 120.h,
          width: Get.width,
        );
      }
      if (block['type'] == "Blurb") {
        preview[3] = Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(
                padding: EdgeInsets.zero,
                text: block['title'],
              ),
              sb30(),
              CloudStorage().imageLoaderProvider(
                ref: block['image'],
                height: 250.h,
                width: Get.width,
              ),
              sb20(),
              description(text: block['description']),
            ],
          ),
        );
      }
      // if (block['type'] == "Carousel") {
      //   preview[2] = Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       title(
      //         text: block['title'],
      //         textAlign: TextAlign.start,
      //       ),
      //       sb10(),
      //       Container(
      //           decoration: BoxDecoration(color: AppColors.carouselBgColor),
      //           child: CarouselSlider(
      //             items: block['images'].map<Widget>((image) {
      //               return CloudStorage().imageLoader(ref: image);
      //             }).toList(),
      //             options: CarouselOptions(
      //               enlargeCenterPage: true,
      //               enlargeStrategy: CenterPageEnlargeStrategy.height,
      //               autoPlay: true,
      //               viewportFraction: 0.8,
      //             ),
      //           )),
      //       sb20(),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           infoTilePreview(
      //               AppEraAssets.floorArea,
      //               TextEditingController(text: block['floor_area'].toString()),
      //               ' sqm',
      //               (value) {}),
      //           infoTilePreview(
      //               AppEraAssets.numberOfBed,
      //               TextEditingController(text: block['beds'].toString()),
      //               '',
      //               (value) {}),
      //           infoTilePreview(
      //               AppEraAssets.loggiaSize,
      //               TextEditingController(
      //                   text: block['loggia_size'].toString()),
      //               ' sqm',
      //               (value) {}),
      //         ],
      //       ),
      //       sb10(),
      //       description(text: block['paragraph']),
      //     ],
      //   );
      // }
    }
    return preview;
  }

  HomebuildPreview() {
    List<Widget> preview = [
      Container(),
      Container(),
      Container(),
      sb50(),
    ];
    for (var block in project.data!) {
      if (block['type'] == "Project Logo") {
        preview[0] = CloudStorage().imageLoaderProvider(
          ref: block['image'],
          height: 91.h,
          width: 241.h,
        );
      }
      if (block['type'] == "Developer Name") {
        preview[1] = Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: EraText(
            textAlign: TextAlign.center,
            text: block['developer_name'],
            color: AppColors.hint,
            fontSize: EraTheme.small,
          ),
        );
      }
      if (block['type'] == "Carousel") {
        preview[2] = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                decoration: BoxDecoration(color: AppColors.carouselBgColor),
                child: CarouselSlider(
                  items: block['images'].map<Widget>((image) {
                    return Container(
                      child: CloudStorage().imageLoader(
                        ref: image,
                        width: Get.width,
                        height: Get.height,
                      ),
                    );

                    //CloudStorage().imageLoader(ref: image);
                  }).toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    viewportFraction: 0.8,
                  ),
                )),
            sb40(),
            Button(
              text: 'LEARN MORE',
              onTap: () {
                Get.to(ProjectView(),
                    binding: ProjectViewBinding(), arguments: project);
              },
              bgColor: AppColors.kRedColor,
              borderRadius: BorderRadius.circular(30),
            ),
            sb10()
          ],
        );
      }
    }
    return preview;
  }

  Widget title({text, color, padding, textAlign}) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth20),
      child: EraText(
        text: text,
        color: color ?? AppColors.kRedColor,
        fontSize: EraTheme.header + 3.sp,
        fontWeight: FontWeight.bold,
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }

  Widget description({text, color, padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: EraText(
        text: text,
        color: color ?? AppColors.black,
        fontSize: EraTheme.subHeader - 2.sp,
        fontWeight: FontWeight.w500,
        maxLines: 20,
      ),
    );
  }

  Widget infoTilePreview(
      String icon, TextEditingController controller, hintText, onChanged) {
    return Row(
      children: [
        Image.asset(icon, width: 70.w, height: 70.h),
        EraText(
          text: controller.text + hintText,
          // controller: controller,
          fontSize: 15.sp,
          color: AppColors.black,
        )
      ],
    );
  }

  Widget infoTile(
      String icon, TextEditingController controller, hintText, onChanged) {
    return Row(
      children: [
        Image.asset(icon, width: 70.w, height: 70.h),
        SizedBox(
          width: 100.w,
          height: 50.h,
          child: TextformfieldWidget(
            contentPadding: EdgeInsets.only(
              top: 10.w,
            ),
            controller: controller,
            hintText: hintText,
            hintstlye: TextStyle(fontSize: 15.sp),
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            readOnly: false,
          ),
        )
      ],
    );
  }
}
