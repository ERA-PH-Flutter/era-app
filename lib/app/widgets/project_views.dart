import 'dart:convert';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/project_view_binding.dart';
import 'package:eraphilippines/presentation/agent/forms/contacts/pages/findus.dart';
import 'package:eraphilippines/presentation/agent/forms/contacts/pages/inquiry.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/sized_box.dart';
import '../constants/theme.dart';
import 'app_text.dart';

class ProjectViews {
  Project project;
  ProjectViews({required this.project});
  Future<bool> loadLink(link, webViewController) async {
    await webViewController.loadRequest(Uri.parse(link));
    return true;
  }

  var currentImage = ''.obs;
  final RxInt currentPage = 0.obs;
  _buildImage({
    height,
    width,
    image,
  }){
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: image
          )
      ),
    );
  }
  build() {
    return CustomScrollView(
        shrinkWrap: true,
        slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var data = project.data![index];

            if (data['type'] == "Banner Images") {
              if(kIsWeb){
                return _buildImage(
                  image: MemoryImage(
                      data['image']
                  ),
                  height: 250.h,
                  width: Get.width
                );
              }else{
                return CloudStorage().imageLoaderProvider(
                  ref: data['image'],
                  height: 250.h,
                  width: Get.width,
                );
              }
            } else if (data['type'] == "Developer Name") {
              return EraText(
                textAlign: TextAlign.center,
                text: data['developer_name'],
                color: AppColors.hint,
                fontSize: EraTheme.small,
              );
            } else if (data['type'] == "Project Logo") {
              if(kIsWeb){
                return _buildImage(
                    image: MemoryImage(
                        data['image']
                    ),
                    height: 250.h,
                    width: Get.width
                );
              }
              return CloudStorage().imageLoaderProvider(
                ref: data['image'],
                height: 150.h,
                width: 241.h,
              );
            } else if (data['type'] == "3D Virtual") {
              if(kIsWeb){
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.w, vertical: 15.h),
                  color: AppColors.hint.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      title(
                        text: data['title'],
                        textAlign: TextAlign.start,
                      ),
                      sb10(),
                      description(text: data['description']),
                      Container(
                        color: Colors.white,
                        height: 150.h,
                        width: Get.width,
                        alignment: Alignment.center,
                        child: EraText(
                          color: Colors.black,
                          fontSize: 20.sp,
                          text: "No Preview for Web!",
                        ),
                      )
                    ],
                  ),
                );
              }else{
                var webViewController = WebViewController();
                webViewController
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setBackgroundColor(const Color(0x00000000))
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onPageStarted: (String url) {},
                      onPageFinished: (String url) {},
                      onWebResourceError: (WebResourceError error) {},
                    ),
                  );
                return Container(
                  color: AppColors.hint.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(
                          text: data['title'],
                          textAlign: TextAlign.start,
                          padding: EdgeInsets.symmetric(
                              horizontal: EraTheme.paddingWidth)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidth),
                        child: description(text: data['description']),
                      ),
                      sb20(),
                      FutureBuilder(
                          future: loadLink(data['link'], webViewController),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var params =
                              const PlatformWebViewControllerCreationParams();
                              var webview =
                              WebViewController.fromPlatformCreationParams(
                                params,
                                onPermissionRequest:
                                    (WebViewPermissionRequest request) {
                                  request.grant();
                                },
                              );
                              return SizedBox(
                                height: 400.h,
                                child: GestureDetector(
                                  child: WebViewWidget(
                                    controller: webViewController,
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                );
              }
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
                    Builder(
                      builder:(context){
                        if(kIsWeb){
                          return _buildImage(
                              image: MemoryImage(
                                  data['image']
                              ),
                              height: 250.h,
                              width: Get.width
                          );
                        }
                        return CloudStorage().imageLoaderProvider(
                          ref: data['image'],
                          height: 250.h,
                          width: Get.width,
                        );
                      }
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
                        position:
                            LatLng(data['location'][0], data['location'][1]),
                        markerId: MarkerId('mainPin'),
                        icon: BitmapDescriptor.defaultMarker)
                  },
                  zoomControlsEnabled: false,
                ),
              );
            } else if (data['type'] == "Outdoor Amenities") {
              if (data['sub_type'] == 'blurb') {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(
                        padding: EdgeInsets.zero,
                        text: data['title'],
                      ),
                      sb30(),
                      Builder(
                        builder: (context){
                          if(kIsWeb){
                            return _buildImage(
                                image: MemoryImage(
                                    data['image']
                                ),
                                height: 250.h,
                                width: Get.width
                            );
                          }
                          return CloudStorage().imageLoaderProvider(
                            ref: data['image'],
                            height: 250.h,
                            width: Get.width,
                          );
                        },
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
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final PageController pageController =
                                PageController(
                                    initialPage: data['images']
                                        .indexOf(currentImage.value));
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 180.h),
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 15.h,
                                          right: 0.w,
                                          left: 0.w,
                                          child: Obx(
                                                () => EraText(
                                              text:
                                              "${data['images'].indexOf(currentImage.value) + 1} / ${data['images'].length}",
                                              textAlign: TextAlign.center,
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Positioned(
                                        top: 0.h,
                                        right: 0.w,
                                        child: IconButton(
                                          color: AppColors.blue3,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            color: AppColors.white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: 60.h,
                                        left: 0.w,
                                        right: 0.w,
                                        bottom: 30.h,
                                        child: PageView.builder(
                                          itemCount: data['images'].length,
                                          controller: pageController,
                                          onPageChanged: (index) {
                                            currentImage.value =
                                            data['images'][index];
                                          },
                                          itemBuilder: (context, index) =>
                                              Center(
                                                child: CloudStorage()
                                                    .imageLoaderProvider(
                                                  ref: data['images'][index],
                                                  height: Get.height,
                                                  width: Get.width,
                                                ),
                                              ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.h,
                                        left: 0,
                                        right: 0,
                                        child: Obx(() {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: List.generate(
                                              data['images'].length,
                                                  (index) {
                                                bool isActive = data['images']
                                                [index] ==
                                                    currentImage.value;
                                                return Container(
                                                  margin:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 3.w),
                                                  width:
                                                  isActive ? 12.w : 8.w,
                                                  height:
                                                  isActive ? 12.h : 8.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isActive
                                                        ? Colors.white
                                                        : Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: Get.width,
                            height: 320.h,
                            child:  Builder(
                              builder: (context){
                                if(kIsWeb){
                                  return _buildImage(
                                    image:MemoryImage(
                                        data['images'][index]
                                    ),
                                    width: Get.width,
                                    height: 250.h,
                                  );
                                }
                                return CloudStorage().imageLoaderProvider(
                                    ref: currentImage.value.isEmpty
                                        ? data['images'][index]
                                        : currentImage.value,
                                    height: 250.h,
                                    width: Get.width);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.h,
                        child: Container(
                          width: Get.width,
                          height: 70.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data['images'].length,
                            itemBuilder: (context, index) {
                              final image = data['images'][index];
                              final isSelected = currentImage.value == image;
                              return GestureDetector(
                                  onTap: () {
                                    currentImage.value = image;
                                  },
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.hint,
                                        width: isSelected ? 5.w : 1.w,
                                      ),
                                    ),
                                    child: Builder(
                                      builder: (context){
                                        if(kIsWeb){
                                          return _buildImage(
                                            image:MemoryImage(
                                                image
                                            ),
                                            width: Get.width / 6,
                                            height: 70.h,
                                          );
                                        }
                                        return CloudStorage().imageLoaderProvider(
                                          ref: image,
                                          width: Get.width / 6,
                                          height: 70.h,
                                        );
                                      },
                                    ),
                                  ));
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(
                        padding: EdgeInsets.zero,
                        text: data['title'],
                      ),
                      sb30(),
                      Builder(
                        builder: (context){
                          if(kIsWeb){
                            return _buildImage(
                                image: MemoryImage(
                                    data['image']
                                ),
                                height: 250.h,
                                width: Get.width
                            );
                          }
                          return CloudStorage().imageLoaderProvider(
                            ref: data['image'],
                            height: 250.h,
                            width: Get.width,
                          );
                        },
                      ),
                      sb20(),
                      description(text: data['description']),
                    ],
                  ),
                );
              } else if (data['sub_type'] == 'gallery') {
                currentImage.value;
                return  SizedBox(
                  height: 350.h,
                  child: Stack(
                    children: [
                      Positioned(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final PageController pageController =
                                PageController(
                                    initialPage: data['images']
                                        .indexOf(currentImage.value));
                                return Dialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 180.h),
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 15.h,
                                          right: 0.w,
                                          left: 0.w,
                                          child: Obx(
                                                () => EraText(
                                              text:
                                              "${data['images'].indexOf(currentImage.value) + 1} / ${data['images'].length}",
                                              textAlign: TextAlign.center,
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Positioned(
                                        top: 0.h,
                                        right: 0.w,
                                        child: IconButton(
                                          color: AppColors.blue3,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(
                                            CupertinoIcons.clear,
                                            color: AppColors.white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: 60.h,
                                        left: 0.w,
                                        right: 0.w,
                                        bottom: 30.h,
                                        child: PageView.builder(
                                          itemCount: data['images'].length,
                                          controller: pageController,
                                          onPageChanged: (index) {
                                            currentImage.value =
                                            data['images'][index];
                                          },
                                          itemBuilder: (context, index) =>
                                              Center(
                                                child: Builder(
                                                    builder:(context){
                                                      if(kIsWeb){
                                                        return _buildImage(
                                                          image: MemoryImage(
                                                              data['images'][index]
                                                          ),
                                                          height: Get.height,
                                                          width: Get.width,
                                                        );
                                                      }
                                                      return CloudStorage()
                                                          .imageLoaderProvider(
                                                        ref: data['images'][index],
                                                        height: Get.height,
                                                        width: Get.width,
                                                      );
                                                    }
                                                ),
                                              ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0.h,
                                        left: 0,
                                        right: 0,
                                        child: Obx(() {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: List.generate(
                                              data['images'].length,
                                                  (index) {
                                                bool isActive = data['images']
                                                [index] ==
                                                    currentImage.value;
                                                return Container(
                                                  margin:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 3.w),
                                                  width:
                                                  isActive ? 12.w : 8.w,
                                                  height:
                                                  isActive ? 12.h : 8.h,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isActive
                                                        ? Colors.white
                                                        : Colors.white
                                                        .withOpacity(0.5),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: Get.width,
                            height: 320.h,
                            child: Builder(
                                builder:(context){
                                  if(kIsWeb){
                                    return _buildImage(
                                      image: MemoryImage(
                                          data['images'][index]
                                      ),
                                      height: 250.h,
                                      width: Get.width,
                                    );
                                  }
                                  return CloudStorage().imageLoaderProvider(
                                    ref: currentImage.value.isEmpty
                                        ? data['images'][index]
                                        : currentImage.value,
                                    height: 250.h,
                                    width: Get.width,
                                  );
                                }
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.h,
                        child: Container(
                          width: Get.width,
                          height: 70.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data['images'].length,
                            itemBuilder: (context, index) {
                              final image = data['images'][index];
                              final isSelected = currentImage.value == image;
                              return GestureDetector(
                                  onTap: () {
                                    currentImage.value = image;
                                  },
                                  child: Container(
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 5.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.hint,
                                        width: isSelected ? 5.w : 1.w,
                                      ),
                                    ),
                                    child: Builder(
                                      builder: (context){
                                        if(kIsWeb){
                                          return _buildImage(
                                            image: MemoryImage(
                                              image
                                            ),
                                            width: Get.width / 6,
                                            height: 70.h,
                                          );
                                        }
                                        return CloudStorage().imageLoaderProvider(
                                          ref: image,
                                          width: Get.width / 6,
                                          height: 70.h,
                                        );
                                      },
                                    ),
                                  ));
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
                              child: Builder(
                                builder: (context){
                                  if(kIsWeb){
                                    return _buildImage(
                                      image: MemoryImage(
                                        image
                                      ),
                                      width: Get.width,
                                      height: Get.height,
                                    );
                                  }
                                  return CloudStorage().imageLoader(
                                    ref: image,
                                    width: Get.width,
                                    height: Get.height,
                                  );
                                },
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
                            TextEditingController(
                                text: data['beds'].toString()),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidth30),
                    ),
                  ],
                ),
              );
            } else if (data['type'] == "Space") {
              return SizedBox(height: data['height'].toString().toDouble());
            }
            return Container();
          },
          childCount: project.data!.length,
        ),
      ),
      SliverToBoxAdapter(
        child:  Builder(
          builder: (context){
            if(kIsWeb){
              return Container();
            }
            return Column(
              children: [
                Inquiry(),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: FindUs(),
                ),
                SizedBox(height: 180.h),
              ],
            );
          },
        ),
      ),
    ]);
  }

  buildPreview() {
    List<Widget> preview = [
      Container(),
      Container(),
      Container(),
    ];
    for (var block in project.data!) {
      if (block['type'] == "Developer Name") {
        preview[0] = Padding(
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
        preview[1] = CloudStorage().imageLoaderProvider(
          ref: block['image'],
          height: 170.h,
          width: Get.width,
        );
      }
      if (block['type'] == "Blurb") {
        preview[2] = Container(
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
              sb40(),
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
    ];
    for (var block in project.data!) {
      if (block['type'] == "Project Logo") {
        preview[0] = CloudStorage().imageLoaderProvider(
          ref: block['image'],
          height: 170.h,
          width: Get.width,
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
