import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/image/image_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/project_view_binding.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/website/projects/pages/project_view.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../presentation/global.dart';
import '../../../presentation/website/landingpage/controller/homs_controller.dart';
import '../../constants/assets.dart';
import '../../constants/sized_box.dart';

class ProjectViewsWeb extends StatelessWidget {
  Project? project;
  ProjectViewsWeb({super.key, this.project});
  Future<bool> loadLink(link, webViewController) async {
    await webViewController.loadRequest(
      Uri.parse(link),
    );
    return true;
  }

  var currentImage = ''.obs;
  final RxInt currentPage = 0.obs;
  var currentImageIndoor = ''.obs;
  var currentImageOutdoor = ''.obs;
  _buildImage({
    height,
    width,
    image,
    fit,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: fit,
        ),
      ),
    );
  }

  // test() {
  //   EraText(
  //     textAlign: TextAlign.center,
  //     text: projectArgument['developer_name'],
  //     color: AppColors.hint,
  //     fontSize: EraTheme.small,
  //   );
  //   print('test');
  // }
  @override
  build(context) {
    project = projectArgument ?? project;
    return Wrap(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: CustomScrollView(shrinkWrap: true, slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var data = project!.data![index];
                  if (data['type'] == "Banner Images") {
                    return CloudStorage().imageLoaderProvider(
                      reference: data['image'],
                      height: Get.height,
                      width: Get.width,
                      fit: BoxFit.cover,
                    );
                  } else if (data['type'] == "Developer Name") {
                    return EraText(
                      textAlign: TextAlign.center,
                      text: data['developer_name'],
                      color: AppColors.hint,
                      fontSize: EraTheme.subHeaderWeb,
                    );
                  } else if (data['type'] == "Project Logo") {
                    return CloudStorage().imageLoaderProvider(
                      reference: data['image'],
                      width: Get.width,
                      fit: BoxFit.contain,
                      height: Get.height / 2,
                    );
                  } else if (data['type'] == "3D Virtual") {
                    var webViewController = WebViewController();
                    print(
                        "api.eraphilippines.com/proxy.php?url=${data['link']}");
                    //webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
                    // webViewController.setNavigationDelegate(NavigationDelegate(
                    //   onPageStarted: (String url) {},
                    //   onPageFinished: (String url) {},
                    //   onWebResourceError: (WebResourceError error) {},
                    // ),);
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
                              future: loadLink(
                                  "https://api.eraphilippines.com/proxy.php?url=${data['link']}",
                                  webViewController),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // var params =
                                  //     const PlatformWebViewControllerCreationParams();
                                  // var webview =
                                  //     WebViewController.fromPlatformCreationParams(
                                  //   params,
                                  //   onPermissionRequest:
                                  //       (WebViewPermissionRequest request) {
                                  //     request.grant();
                                  //   },
                                  // );
                                  return SizedBox(
                                    width: double.infinity,
                                    height: Get.height,
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
                  } else if (data['type'] == "Blurb") {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(
                            padding: EdgeInsets.zero,
                            text: data['title'],
                          ),
                          sb30(),
                          Builder(builder: (context) {
                            if (kIsWeb) {
                              return CloudStorage().imageLoaderProvider(
                                reference: data['image'],
                                height: Get.height,
                                width: Get.width,
                              );
                            }
                            return ImageWidget(
                              thumbnailUrl: data['image'],
                              height: 250.h,
                              width: Get.width,
                            );
                            // CloudStorage().imageLoaderProvider(
                            //   reference: data['image'],
                            //   height: 250.h,
                            //   width: Get.width,
                            // );
                          }),
                          sb20(),
                          description(text: data['description']),
                        ],
                      ),
                    );
                  } else if (data['type'] == "Location") {
                    return SizedBox(
                      height: 350.h,
                      width: Get.width,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                data['location'][0], data['location'][1]),
                            zoom: 15),
                        markers: {
                          Marker(
                              position: LatLng(
                                  data['location'][0], data['location'][1]),
                              markerId: MarkerId('mainPin'),
                              icon: BitmapDescriptor.defaultMarker)
                        },
                        zoomControlsEnabled: false,
                      ),
                    );
                  } else if (data['type'] == "Outdoor Amenities") {
                    if (data['sub_type'] == 'blurb') {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(
                              padding: EdgeInsets.zero,
                              text: data['title'],
                            ),
                            sb30(),
                            Builder(
                              builder: (context) {
                                if (kIsWeb) {
                                  return CloudStorage().imageLoaderProvider(
                                    reference: data['image'],
                                    height: Get.height,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  );
                                }
                                return ImageWidget(
                                  thumbnailUrl: data['image'],
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
                        height: Get.height,
                        child: Stack(
                          children: [
                            Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: Get.context!,
                                    builder: (BuildContext context) {
                                      final PageController pageController =
                                          PageController(
                                              initialPage: data['images']
                                                  .indexOf(currentImageOutdoor
                                                      .value));
                                      return Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 0.h),
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 20.h,
                                                right: 0.w,
                                                left: 0.w,
                                                child: Obx(
                                                  () => EraText(
                                                    text:
                                                        "${data['images'].indexOf(currentImageOutdoor.value) + 1} / ${data['images'].length}",
                                                    textAlign: TextAlign.center,
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                            Positioned(
                                              top: 5.h,
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
                                                itemCount:
                                                    data['images'].length,
                                                controller: pageController,
                                                onPageChanged: (index) {
                                                  currentImageOutdoor.value =
                                                      data['images'][index];
                                                },
                                                itemBuilder: (context, index) =>
                                                    Center(
                                                  child: Builder(
                                                      builder: (context) {
                                                    if (kIsWeb) {
                                                      if (data['image'] !=
                                                          null) {
                                                        return CloudStorage()
                                                            .imageLoaderProvider(
                                                          reference:
                                                              data['images']
                                                                  [index],
                                                          width: Get.width,
                                                          height: Get.height,
                                                        );
                                                      } else {
                                                        return CloudStorage()
                                                            .imageLoaderProvider(
                                                          reference:
                                                              data['images']
                                                                  [index],
                                                          width: Get.width,
                                                          height: Get.height,
                                                        );
                                                      }
                                                    }
                                                    return Wrap(
                                                      children: [
                                                        InteractiveViewer(
                                                          clipBehavior:
                                                              Clip.none,
                                                          minScale: 1.0,
                                                          maxScale: 4.0,
                                                          child: CloudStorage()
                                                              .imageLoaderProvider(
                                                            reference:
                                                                data['image'],
                                                            height: Get.height,
                                                            width: Get.width,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 30,
                                              left: 0,
                                              right: 0,
                                              child: Obx(() {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                    data['images'].length,
                                                    (index) {
                                                      bool isActive = data[
                                                                  'images']
                                                              [index] ==
                                                          currentImageOutdoor
                                                              .value;
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    3.w),
                                                        width: isActive
                                                            ? 12.w
                                                            : 8.w,
                                                        height: isActive
                                                            ? 12.h
                                                            : 8.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: isActive
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.5),
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
                                child: SizedBox(
                                  width: Get.width,
                                  height: Get.height,
                                  child: Obx(() {
                                    print(
                                        'currentImageOutdoor.value   ${data['images'][0]}');
                                    final displayImage =
                                        currentImageOutdoor.value.isNotEmpty
                                            ? currentImageOutdoor.value
                                            : (data['images'] != null &&
                                                    data['images'].isNotEmpty)
                                                ? data['images'][0]
                                                : null;

                                    if (kIsWeb) {
                                      return CloudStorage().imageLoaderProvider(
                                        reference: displayImage,
                                        width: Get.width,
                                        height: Get.height,
                                      );
                                    }
                                    return CloudStorage().imageLoaderProvider(
                                      reference: displayImage,
                                      width: Get.width,
                                      height: Get.height,
                                    );

                                    //  ImageWidget(
                                    //   thumbnailUrl: data['images'][0],
                                    //   height: 250.h,
                                    //   width: Get.width,
                                    // );
                                  }),
                                ),
                              ),
                            ),
                            Obx(
                              () => Positioned(
                                bottom: 0.h,
                                child: SizedBox(
                                  width: Get.width,
                                  height: 100.h,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        data['images'].length, (index) {
                                      final image = data['images'][index];
                                      final isSelected =
                                          currentImageOutdoor.value == image;
                                      return GestureDetector(
                                        onTap: () {
                                          currentImageOutdoor.value = image;
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.hint,
                                              width: isSelected ? 5.w : 1.w,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              if (kIsWeb) {
                                                if (data['image'] != null) {
                                                  return CloudStorage()
                                                      .imageLoaderProvider(
                                                    reference: data['image'][0],
                                                    width: Get.width / 6,
                                                    height: 100.h,
                                                  );
                                                }
                                              }
                                              return CloudStorage()
                                                  .imageLoaderProvider(
                                                reference: image,
                                                width: Get.width / 8,
                                                height: 100.h,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(
                              padding: EdgeInsets.zero,
                              text: data['title'],
                            ),
                            sb30(),
                            Builder(
                              builder: (context) {
                                if (kIsWeb) {
                                  return CloudStorage().imageLoaderProvider(
                                    reference: data['image'],
                                    width: Get.width,
                                    height: 250.h,
                                  );

                                  // _buildImage(
                                  //     image: MemoryImage(data['image']),
                                  //     height: 250.h,
                                  //     width: Get.width);
                                }
                                return ImageWidget(
                                  thumbnailUrl: data['image'],
                                  height: 250.h,
                                  width: Get.width,
                                );

                                // CloudStorage().imageLoaderProvider(
                                //   reference: data['image'],
                                //   height: 250.h,
                                //   width: Get.width,
                                // );
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
                                                  .indexOf(currentImageIndoor
                                                      .value));
                                      return Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 180.h),
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 20.h,
                                                right: 10.w,
                                                left: 0.w,
                                                child: Obx(
                                                  () => EraText(
                                                    text:
                                                        "${data['images'].indexOf(currentImageIndoor.value) + 1} / ${data['images'].length}",
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
                                                itemCount:
                                                    data['images'].length,
                                                controller: pageController,
                                                onPageChanged: (index) {
                                                  currentImageIndoor.value =
                                                      data['images'][index];
                                                },
                                                itemBuilder: (context, index) =>
                                                    Center(
                                                  child: Builder(
                                                      builder: (context) {
                                                    if (kIsWeb) {
                                                      if (data['image'] !=
                                                          null) {
                                                        return CloudStorage()
                                                            .imageLoaderProvider(
                                                          reference:
                                                              data['image']
                                                                  [index],
                                                          width: Get.width,
                                                          height: Get.height,
                                                        );
                                                      } else {
                                                        return CloudStorage()
                                                            .imageLoaderProvider(
                                                          reference:
                                                              data['images']
                                                                  [index],
                                                          width: Get.width,
                                                          height: Get.height,
                                                        );

                                                        //    return CloudStorage()
                                                        //     .imageLoaderProvider(
                                                        //   reference:
                                                        //       data['images']
                                                        //           [index],
                                                        //   width: Get.width,
                                                        //   height: Get.height,
                                                        // );
                                                      }
                                                    }
                                                    return Wrap(
                                                      children: [
                                                        InteractiveViewer(
                                                          clipBehavior:
                                                              Clip.none,
                                                          minScale: 1.0,
                                                          maxScale: 4.0,
                                                          child: ImageWidget(
                                                            thumbnailUrl:
                                                                data['images']
                                                                    [index],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 20.h,
                                              left: 0,
                                              right: 0,
                                              child: Obx(() {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                    data['images'].length,
                                                    (index) {
                                                      bool isActive =
                                                          data['images']
                                                                  [index] ==
                                                              currentImageIndoor
                                                                  .value;
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    3.w),
                                                        width: isActive
                                                            ? 12.w
                                                            : 8.w,
                                                        height: isActive
                                                            ? 12.h
                                                            : 8.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: isActive
                                                              ? Colors.white
                                                              : Colors.white
                                                                  .withOpacity(
                                                                      0.5),
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
                                child: SizedBox(
                                  width: Get.width,
                                  height: 320.h,
                                  child: Obx(() {
                                    print(
                                        'currentImageIndoor.value   ${data['images'][0]}');
                                    final displayImage =
                                        currentImageIndoor.value.isNotEmpty
                                            ? currentImageIndoor.value
                                            : (data['images'] != null &&
                                                    data['images'].isNotEmpty)
                                                ? data['images'][0]
                                                : null;

                                    if (kIsWeb) {
                                      return CloudStorage().imageLoaderProvider(
                                        reference: displayImage,
                                        width: Get.width,
                                        height: Get.height,
                                      );
                                    }
                                    return CloudStorage().imageLoaderProvider(
                                      reference: displayImage,
                                      width: Get.width,
                                      height: Get.height,
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Obx(
                              () => Positioned(
                                bottom: 0.h,
                                child: SizedBox(
                                  width: Get.width,
                                  height: 100.h,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        data['images'].length, (index) {
                                      final image = data['images'][index];
                                      final isSelected =
                                          currentImageIndoor.value == image;
                                      return GestureDetector(
                                          onTap: () {
                                            currentImageIndoor.value = image;
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.hint,
                                                width: isSelected ? 5.w : 1.w,
                                              ),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                if (kIsWeb) {
                                                  if (data['image'] != null) {
                                                    return CloudStorage()
                                                        .imageLoaderProvider(
                                                      reference: data['image']
                                                          [0],
                                                      width: Get.width / 6,
                                                      height: 100.h,
                                                    );
                                                  }

                                                  // _buildImage(
                                                  //   image: MemoryImage(image),
                                                  //   width: Get.width / 6,
                                                  //   height: 70.h,
                                                  // );
                                                }
                                                return CloudStorage()
                                                    .imageLoaderProvider(
                                                  reference: image,
                                                  width: Get.width / 8,
                                                  height: 100.h,
                                                );

                                                // CloudStorage()
                                                //     .imageLoaderProvider(
                                                //   reference: image,
                                                //   width: Get.width / 6,
                                                //   height: 70.h,
                                                // );
                                              },
                                            ),
                                          ));
                                    }),
                                  ),
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
                              height: Get.height,
                              padding: EdgeInsets.only(
                                  right: EraTheme.paddingWidthAdmin * 2,
                                  left: EraTheme.paddingWidthAdmin * 2,
                                  top: EraTheme.paddingWidth20,
                                  bottom: EraTheme.paddingWidth20),
                              child: CarouselSlider(
                                items: data['images'].map<Widget>((image) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CloudStorage().imageLoader(
                                      reference: image,
                                      fit: BoxFit.cover,
                                      width: Get.width,
                                      height: Get.height,
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  autoPlay: true,
                                  // enlargeFactor: 0.4,
                                  // // enableInfiniteScroll: true,103099Seb
                                  // viewportFraction: 0.7,
                                  // aspectRatio: 1.9,
                                  viewportFraction: 0.8,
                                  height: Get.height / 1.2,
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
                    return SizedBox(
                        height: data['height'].toString().toDouble());
                  }
                  return Container();
                },
                childCount: project!.data!.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  if (kIsWeb) {
                    return Container();
                  }
                  return Column(
                    children: [
                      //       Inquiry(),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //  child: FindUs(),
                      ),
                      SizedBox(height: 180.h),
                    ],
                  );
                },
              ),
            ),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       var data = project!.data![index];
            //       if (data['type'] == "Banner Images") {
            //         return CloudStorage().imageLoaderProvider(
            //           reference: data['image'],
            //           height: Get.height,
            //           width: Get.width,
            //           fit: BoxFit.cover,
            //         );
            //       } else if (data['type'] == "Developer Name") {
            //         return EraText(
            //           textAlign: TextAlign.center,
            //           text: data['developer_name'],
            //           color: AppColors.hint,
            //           fontSize: EraTheme.subHeaderWeb,
            //         );
            //       } else if (data['type'] == "Project Logo") {
            //         return CloudStorage().imageLoaderProvider(
            //           reference: data['image'],
            //           width: Get.width,
            //           fit: BoxFit.contain,
            //           height: Get.height / 2,
            //         );
            //       } else if (data['type'] == "3D Virtual") {
            //         var webViewController = WebViewController();
            //         print(
            //             "api.eraphilippines.com/proxy.php?url=${data['link']}");
            //         //webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
            //         // webViewController.setNavigationDelegate(NavigationDelegate(
            //         //   onPageStarted: (String url) {},
            //         //   onPageFinished: (String url) {},
            //         //   onWebResourceError: (WebResourceError error) {},
            //         // ),);
            //         return Container(
            //           color: AppColors.hint.withOpacity(0.3),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               title(
            //                   text: data['title'],
            //                   textAlign: TextAlign.start,
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: EraTheme.paddingWidth)),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: EraTheme.paddingWidth),
            //                 child: description(text: data['description']),
            //               ),
            //               sb20(),
            //               FutureBuilder(
            //                   future: loadLink(
            //                       "https://api.eraphilippines.com/proxy.php?url=${data['link']}",
            //                       webViewController),
            //                   builder: (context, snapshot) {
            //                     if (snapshot.hasData) {
            //                       // var params =
            //                       //     const PlatformWebViewControllerCreationParams();
            //                       // var webview =
            //                       //     WebViewController.fromPlatformCreationParams(
            //                       //   params,
            //                       //   onPermissionRequest:
            //                       //       (WebViewPermissionRequest request) {
            //                       //     request.grant();
            //                       //   },
            //                       // );
            //                       return SizedBox(
            //                         width: double.infinity,
            //                         height: Get.height,
            //                         child: GestureDetector(
            //                           child: WebViewWidget(
            //                             controller: webViewController,
            //                           ),
            //                         ),
            //                       );
            //                     } else {
            //                       return Center(
            //                         child: CircularProgressIndicator(),
            //                       );
            //                     }
            //                   }),
            //             ],
            //           ),
            //         );
            //       } else if (data['type'] == "Blurb") {
            //         return Container(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 30.w, vertical: 15.h),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               title(
            //                 padding: EdgeInsets.zero,
            //                 text: data['title'],
            //               ),
            //               sb30(),
            //               CloudStorage().imageLoaderProvider(
            //                 reference: data['image'],
            //                 height: Get.height,
            //                 width: Get.width,
            //               ),
            //               sb20(),
            //               description(text: data['description']),
            //             ],
            //           ),
            //         );
            //       } else if (data['type'] == "Location") {
            //         return Container(
            //           height: Get.height,
            //           width: Get.width,
            //           child: GoogleMap(
            //             initialCameraPosition: CameraPosition(
            //                 target: LatLng(
            //                     data['location'][0], data['location'][1]),
            //                 zoom: 15),
            //             markers: {
            //               Marker(
            //                   position: LatLng(
            //                       data['location'][0], data['location'][1]),
            //                   markerId: MarkerId('mainPin'),
            //                   icon: BitmapDescriptor.defaultMarker)
            //             },
            //             zoomControlsEnabled: false,
            //           ),
            //         );
            //       } else if (data['type'] == "Outdoor Amenities") {
            //         if (data['sub_type'] == 'blurb') {
            //           return Container(
            //             padding: EdgeInsets.symmetric(
            //                 horizontal: 30.w, vertical: 15.h),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 title(
            //                   padding: EdgeInsets.zero,
            //                   text: data['title'],
            //                 ),
            //                 sb30(),
            //                 CloudStorage().imageLoaderProvider(
            //                   reference: data['image'],
            //                   height: Get.height,
            //                   width: Get.width,
            //                 ),
            //                 sb20(),
            //                 description(text: data['description']),
            //               ],
            //             ),
            //           );
            //         } else if (data['sub_type'] == 'gallery') {
            //           SizedBox(
            //             height: 350.h,
            //             child: Stack(
            //               children: [
            //                 Positioned(
            //                   child: GestureDetector(
            //                     onTap: () {
            //                       showDialog(
            //                         context: context,
            //                         builder: (BuildContext context) {
            //                           final PageController pageController =
            //                               PageController(
            //                                   initialPage: data['images']
            //                                       .indexOf(currentImageOutdoor
            //                                           .value));
            //                           return Dialog(
            //                             insetPadding: EdgeInsets.symmetric(
            //                                 horizontal: 5.w, vertical: 0.h),
            //                             backgroundColor: Colors.transparent,
            //                             child: Stack(
            //                               children: [
            //                                 Positioned(
            //                                     top: 20.h,
            //                                     right: 0.w,
            //                                     left: 0.w,
            //                                     child: Obx(
            //                                       () => EraText(
            //                                         text:
            //                                             "${data['images'].indexOf(currentImageOutdoor.value) + 1} / ${data['images'].length}",
            //                                         textAlign: TextAlign.center,
            //                                         color: Colors.white,
            //                                         fontSize: 18.sp,
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                     )),
            //                                 Positioned(
            //                                   top: 5.h,
            //                                   right: 0.w,
            //                                   child: IconButton(
            //                                     color: AppColors.blue3,
            //                                     onPressed: () {
            //                                       Get.back();
            //                                     },
            //                                     icon: Icon(
            //                                       CupertinoIcons.clear,
            //                                       color: AppColors.white,
            //                                       size: 30.sp,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 Positioned.fill(
            //                                   top: 60.h,
            //                                   left: 0.w,
            //                                   right: 0.w,
            //                                   bottom: 30.h,
            //                                   child: PageView.builder(
            //                                     itemCount:
            //                                         data['images'].length,
            //                                     controller: pageController,
            //                                     onPageChanged: (index) {
            //                                       currentImageOutdoor.value =
            //                                           data['images'][index];
            //                                     },
            //                                     itemBuilder: (context, index) =>
            //                                         Center(
            //                                       child: Builder(
            //                                           builder: (context) {
            //                                         if (kIsWeb) {
            //                                           return Wrap(
            //                                             children: [
            //                                               _buildImage(
            //                                                 image: MemoryImage(
            //                                                     data['images']
            //                                                         [index]),
            //                                                 height: Get.height,
            //                                                 width: Get.width,
            //                                               )
            //                                             ],
            //                                           );
            //                                         }
            //                                         return Wrap(
            //                                           children: [
            //                                             InteractiveViewer(
            //                                               clipBehavior:
            //                                                   Clip.none,
            //                                               minScale: 1.0,
            //                                               maxScale: 4.0,
            //                                               child: ImageWidget(
            //                                                 thumbnailUrl:
            //                                                     data['images']
            //                                                         [index],
            //                                                 fit: BoxFit.cover,
            //                                               ),
            //                                             ),
            //                                             // CloudStorage().imageLoader(
            //                                             //   reference: data['images']
            //                                             //       [index],
            //                                             //   fit: BoxFit.cover,
            //                                             // ),
            //                                           ],
            //                                         );
            //                                       }),
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 Positioned(
            //                                   bottom: 30,
            //                                   left: 0,
            //                                   right: 0,
            //                                   child: Obx(() {
            //                                     return Row(
            //                                       mainAxisAlignment:
            //                                           MainAxisAlignment.center,
            //                                       children: List.generate(
            //                                         data['images'].length,
            //                                         (index) {
            //                                           bool isActive = data[
            //                                                       'images']
            //                                                   [index] ==
            //                                               currentImageOutdoor
            //                                                   .value;
            //                                           return Container(
            //                                             margin: EdgeInsets
            //                                                 .symmetric(
            //                                                     horizontal:
            //                                                         3.w),
            //                                             width: isActive
            //                                                 ? 12.w
            //                                                 : 8.w,
            //                                             height: isActive
            //                                                 ? 12.h
            //                                                 : 8.h,
            //                                             decoration:
            //                                                 BoxDecoration(
            //                                               shape:
            //                                                   BoxShape.circle,
            //                                               color: isActive
            //                                                   ? Colors.white
            //                                                   : Colors.white
            //                                                       .withOpacity(
            //                                                           0.5),
            //                                             ),
            //                                           );
            //                                         },
            //                                       ),
            //                                     );
            //                                   }),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         },
            //                       );
            //                     },
            //                     child: SizedBox(
            //                       width: Get.width,
            //                       height: 320.h,
            //                       child: Obx(() {
            //                         final displayImage =
            //                             currentImageOutdoor.value.isNotEmpty
            //                                 ? currentImageOutdoor.value
            //                                 : data['images'].isNotEmpty
            //                                     ? data['images'][0]
            //                                     : null;

            //                         if (displayImage == null) {
            //                           return Container();
            //                         }

            //                         if (kIsWeb) {
            //                           return _buildImage(
            //                             image: MemoryImage(displayImage),
            //                             width: Get.width,
            //                             height: 50.h,
            //                           );
            //                         }
            //                         return ImageWidget(
            //                           thumbnailUrl: displayImage,
            //                           height: 250.h,
            //                           width: Get.width,
            //                         );

            //                         // CloudStorage().imageLoader(
            //                         //   reference: displayImage,
            //                         //   height: 250.h,
            //                         //   width: Get.width,
            //                         // );
            //                       }),
            //                     ),
            //                   ),
            //                 ),
            //                 Obx(
            //                   () => Positioned(
            //                     bottom: 0.h,
            //                     child: SizedBox(
            //                       width: Get.width,
            //                       height: 70.h,
            //                       child: ListView(
            //                         scrollDirection: Axis.horizontal,
            //                         children: List.generate(
            //                             data['images'].length, (index) {
            //                           final image = data['images'][index];
            //                           final isSelected =
            //                               currentImageOutdoor.value == image;
            //                           return GestureDetector(
            //                             onTap: () {
            //                               currentImageOutdoor.value = image;
            //                             },
            //                             child: Container(
            //                               margin: EdgeInsets.symmetric(
            //                                   horizontal: 5.w),
            //                               decoration: BoxDecoration(
            //                                 border: Border.all(
            //                                   color: AppColors.hint,
            //                                   width: isSelected ? 5.w : 1.w,
            //                                 ),
            //                               ),
            //                               child: Builder(
            //                                 builder: (context) {
            //                                   if (kIsWeb) {
            //                                     return _buildImage(
            //                                       image: MemoryImage(image),
            //                                       width: Get.width / 6,
            //                                       height: 70.h,
            //                                     );
            //                                   }
            //                                   return ImageWidget(
            //                                     thumbnailUrl: image,
            //                                     height: 70.h,
            //                                     width: Get.width / 6,
            //                                   );

            //                                 },
            //                               ),
            //                             ),
            //                           );
            //                         }),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }
            //       } else if (data['type'] == "Indoor Amenities") {
            //         if (data['sub_type'] == 'blurb') {
            //           return Container(
            //             padding: EdgeInsets.symmetric(
            //                 horizontal: 30.w, vertical: 15.h),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 title(
            //                   padding: EdgeInsets.zero,
            //                   text: data['title'],
            //                 ),
            //                 sb30(),
            //                 Builder(
            //                   builder: (context) {
            //                     if (kIsWeb) {
            //                       return _buildImage(
            //                           image: MemoryImage(data['image']),
            //                           height: 250.h,
            //                           width: Get.width);
            //                     }
            //                     return ImageWidget(
            //                       thumbnailUrl: data['image'],
            //                       height: 250.h,
            //                       width: Get.width,
            //                     );

            //                     // CloudStorage().imageLoaderProvider(
            //                     //   reference: data['image'],
            //                     //   height: 250.h,
            //                     //   width: Get.width,
            //                     // );
            //                   },
            //                 ),
            //                 sb20(),
            //                 description(text: data['description']),
            //               ],
            //             ),
            //           );
            //         } else if (data['sub_type'] == 'gallery') {
            //           return SizedBox(
            //             height: 350.h,
            //             child: Stack(
            //               children: [
            //                 Positioned(
            //                   child: GestureDetector(
            //                     onTap: () {
            //                       showDialog(
            //                         context: context,
            //                         builder: (BuildContext context) {
            //                           final PageController pageController =
            //                               PageController(
            //                                   initialPage: data['images']
            //                                       .indexOf(currentImageIndoor
            //                                           .value));
            //                           return Dialog(
            //                             insetPadding: EdgeInsets.symmetric(
            //                                 horizontal: 5.w, vertical: 180.h),
            //                             backgroundColor: Colors.transparent,
            //                             child: Stack(
            //                               children: [
            //                                 Positioned(
            //                                     top: 20.h,
            //                                     right: 10.w,
            //                                     left: 0.w,
            //                                     child: Obx(
            //                                       () => EraText(
            //                                         text:
            //                                             "${data['images'].indexOf(currentImageIndoor.value) + 1} / ${data['images'].length}",
            //                                         textAlign: TextAlign.center,
            //                                         color: Colors.white,
            //                                         fontSize: 18.sp,
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                     )),
            //                                 Positioned(
            //                                   top: 0.h,
            //                                   right: 0.w,
            //                                   child: IconButton(
            //                                     color: AppColors.blue3,
            //                                     onPressed: () {
            //                                       Get.back();
            //                                     },
            //                                     icon: Icon(
            //                                       CupertinoIcons.clear,
            //                                       color: AppColors.white,
            //                                       size: 30.sp,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 Positioned.fill(
            //                                   top: 60.h,
            //                                   left: 0.w,
            //                                   right: 0.w,
            //                                   bottom: 30.h,
            //                                   child: PageView.builder(
            //                                     itemCount:
            //                                         data['images'].length,
            //                                     controller: pageController,
            //                                     onPageChanged: (index) {
            //                                       currentImageIndoor.value =
            //                                           data['images'][index];
            //                                     },
            //                                     itemBuilder: (context, index) =>
            //                                         Center(
            //                                       child: Builder(
            //                                           builder: (context) {
            //                                         if (kIsWeb) {
            //                                           return Wrap(
            //                                             children: [
            //                                               _buildImage(
            //                                                 image: MemoryImage(
            //                                                     data['images']
            //                                                         [index]),
            //                                                 height: Get.height,
            //                                                 width: Get.width,
            //                                               )
            //                                             ],
            //                                           );
            //                                         }
            //                                         return Wrap(
            //                                           children: [
            //                                             InteractiveViewer(
            //                                               clipBehavior:
            //                                                   Clip.none,
            //                                               minScale: 1.0,
            //                                               maxScale: 4.0,
            //                                               child: ImageWidget(
            //                                                 thumbnailUrl:
            //                                                     data['images']
            //                                                         [index],
            //                                                 fit: BoxFit.cover,
            //                                               ),
            //                                             ),
            //                                             // CloudStorage().imageLoader(
            //                                             //   reference: data['images']
            //                                             //       [index],
            //                                             //   fit: BoxFit.cover,
            //                                             // ),
            //                                           ],
            //                                         );
            //                                       }),
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 Positioned(
            //                                   bottom: 20.h,
            //                                   left: 0,
            //                                   right: 0,
            //                                   child: Obx(() {
            //                                     return Row(
            //                                       mainAxisAlignment:
            //                                           MainAxisAlignment.center,
            //                                       children: List.generate(
            //                                         data['images'].length,
            //                                         (index) {
            //                                           bool isActive =
            //                                               data['images']
            //                                                       [index] ==
            //                                                   currentImageIndoor
            //                                                       .value;
            //                                           return Container(
            //                                             margin: EdgeInsets
            //                                                 .symmetric(
            //                                                     horizontal:
            //                                                         3.w),
            //                                             width: isActive
            //                                                 ? 12.w
            //                                                 : 8.w,
            //                                             height: isActive
            //                                                 ? 12.h
            //                                                 : 8.h,
            //                                             decoration:
            //                                                 BoxDecoration(
            //                                               shape:
            //                                                   BoxShape.circle,
            //                                               color: isActive
            //                                                   ? Colors.white
            //                                                   : Colors.white
            //                                                       .withOpacity(
            //                                                           0.5),
            //                                             ),
            //                                           );
            //                                         },
            //                                       ),
            //                                     );
            //                                   }),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         },
            //                       );
            //                     },
            //                     child: SizedBox(
            //                       width: Get.width,
            //                       height: 320.h,
            //                       child: Obx(() {
            //                         final displayImage =
            //                             currentImageIndoor.value.isNotEmpty
            //                                 ? currentImageIndoor.value
            //                                 : data['images'].isNotEmpty
            //                                     ? data['images'][0]
            //                                     : null;
            //                         if (displayImage == null) {
            //                           return Container();
            //                         }

            //                         if (kIsWeb) {
            //                           return _buildImage(
            //                             image: MemoryImage(displayImage),
            //                             width: Get.width,
            //                             height: 50.h,
            //                           );
            //                         }
            //                         return ImageWidget(
            //                           thumbnailUrl: displayImage,
            //                           height: 250.h,
            //                           width: Get.width,
            //                         );

            //                         // CloudStorage().imageLoaderProvider(
            //                         //   reference: displayImage,
            //                         //   height: 250.h,
            //                         //   width: Get.width,
            //                         // );
            //                       }),
            //                     ),
            //                   ),
            //                 ),
            //                 Obx(
            //                   () => Positioned(
            //                     bottom: 0.h,
            //                     child: SizedBox(
            //                       width: Get.width,
            //                       height: 70.h,
            //                       child: ListView(
            //                         scrollDirection: Axis.horizontal,
            //                         children: List.generate(
            //                             data['images'].length, (index) {
            //                           final image = data['images'][index];
            //                           final isSelected =
            //                               currentImageIndoor.value == image;
            //                           return GestureDetector(
            //                               onTap: () {
            //                                 currentImageIndoor.value = image;
            //                               },
            //                               child: Container(
            //                                 margin: EdgeInsets.symmetric(
            //                                     horizontal: 5.w),
            //                                 decoration: BoxDecoration(
            //                                   border: Border.all(
            //                                     color: AppColors.hint,
            //                                     width: isSelected ? 5.w : 1.w,
            //                                   ),
            //                                 ),
            //                                 child: Builder(
            //                                   builder: (context) {
            //                                     if (kIsWeb) {
            //                                       return _buildImage(
            //                                         image: MemoryImage(image),
            //                                         width: Get.width / 6,
            //                                         height: 70.h,
            //                                       );
            //                                     }
            //                                     return ImageWidget(
            //                                       thumbnailUrl: image,
            //                                       height: 70.h,
            //                                       width: Get.width / 6,
            //                                     );

            //                                     // CloudStorage()
            //                                     //     .imageLoaderProvider(
            //                                     //   reference: image,
            //                                     //   width: Get.width / 6,
            //                                     //   height: 70.h,
            //                                     // );
            //                                   },
            //                                 ),
            //                               ));
            //                         }),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }
            //       } else if (data['type'] == "Carousel") {
            //         return Container(
            //           color: AppColors.hint.withOpacity(0.3),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               sb20(),
            //               title(
            //                 text: data['title'],
            //                 textAlign: TextAlign.start,
            //               ),
            //               sb10(),
            //               Container(
            //                   height: Get.height,
            //                   padding: EdgeInsets.only(
            //                       right: EraTheme.paddingWidthAdmin * 2,
            //                       left: EraTheme.paddingWidthAdmin * 2,
            //                       top: EraTheme.paddingWidth20,
            //                       bottom: EraTheme.paddingWidth20),
            //                   child: CarouselSlider(
            //                     items: data['images'].map<Widget>((image) {
            //                       return ClipRRect(
            //                         borderRadius: BorderRadius.circular(30),
            //                         child: CloudStorage().imageLoader(
            //                           reference: image,
            //                           fit: BoxFit.cover,
            //                           width: Get.width,
            //                           height: Get.height,
            //                         ),
            //                       );
            //                     }).toList(),
            //                     options: CarouselOptions(
            //                       enlargeCenterPage: true,
            //                       enlargeStrategy:
            //                           CenterPageEnlargeStrategy.height,
            //                       autoPlay: true,
            //                       // enlargeFactor: 0.4,
            //                       // // enableInfiniteScroll: true,103099Seb
            //                       // viewportFraction: 0.7,
            //                       // aspectRatio: 1.9,
            //                       viewportFraction: 0.8,
            //                       height: Get.height / 1.2,
            //                     ),
            //                   )),
            //               sb20(),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   infoTilePreview(
            //                       AppEraAssets.floorArea,
            //                       TextEditingController(
            //                           text: data['floor_area'].toString()),
            //                       ' sqm',
            //                       (value) {}),
            //                   infoTilePreview(
            //                       AppEraAssets.numberOfBed,
            //                       TextEditingController(
            //                           text: data['beds'].toString()),
            //                       '',
            //                       (value) {}),
            //                   infoTilePreview(
            //                       AppEraAssets.loggiaSize,
            //                       TextEditingController(
            //                           text: data['loggia_size'].toString()),
            //                       ' sqm',
            //                       (value) {}),
            //                 ],
            //               ),
            //               sb20(),
            //               description(
            //                 text: data['paragraph'],
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: EraTheme.paddingWidth30),
            //               ),
            //             ],
            //           ),
            //         );
            //       } else if (data['type'] == "Space") {
            //         return SizedBox(
            //             height: data['height'].toString().toDouble());
            //       }
            //       return Container();
            //     },
            //     childCount: project!.data!.length,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       // Inquiry(),
            //       SizedBox(height: 40.h),
            //       // Padding(
            //       //   padding: EdgeInsets.symmetric(horizontal: 10.w),
            //       //   child: FindUs(),
            //       // ),
            //       SizedBox(height: 180.h),
            //     ],
            //   ),
            // ),
          ]),
        ),
      ],
    );
  }

  buildPreview() {
    List<Widget> preview = [
      Container(),
      Container(),
      Container(),
      sb50(),
    ];
    for (var block in project!.data!) {
      if (block['type'] == "Developer Name") {
        preview[1] = Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: EraText(
            textAlign: TextAlign.center,
            text: block['developer_name'],
            color: AppColors.hint,
            fontSize: EraTheme.subHeaderWeb,
          ),
        );
      }
      if (block['type'] == "Project Logo") {
        preview[2] = CloudStorage().imageLoader(
          reference: block['image'],
          width: Get.width,
          fit: BoxFit.contain,
          height: Get.height / 2,
        );
      }
      if (block['type'] == "Blurb") {
        preview[3] = Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(
                padding: EdgeInsets.zero,
                text: block['title'],
              ),
              sb30(),
              CloudStorage().imageLoaderProvider(
                reference: block['image'],
                height: Get.height,
                width: Get.width,
              ),
              sb20(),
              description(text: block['description']),
            ],
          ),
        );
      }
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

    for (var block in project!.data!) {
      if (block['type'] == "Project Logo") {
        preview[0] = CloudStorage().imageLoader(
            reference: block['image'],
            height: Get.height / 2,
            width: Get.width,
            fit: BoxFit.contain);
      }
      if (block['type'] == "Developer Name") {
        preview[1] = Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: EraText(
              textAlign: TextAlign.center,
              text: block['developer_name'],
              color: AppColors.hint,
              fontSize: EraTheme.subHeaderWeb),
        );
      }
      if (block['type'] == "Carousel") {
        preview[2] = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: Get.height,
                padding: EdgeInsets.only(
                    right: EraTheme.paddingWidthAdmin * 2,
                    left: EraTheme.paddingWidthAdmin * 2,
                    top: EraTheme.paddingWidth20,
                    bottom: EraTheme.paddingWidth20),
                decoration: BoxDecoration(color: AppColors.carouselBgColor),
                child: CarouselSlider(
                  items: block['images'].map<Widget>((image) {
                    return Container(
                      child: CloudStorage().imageLoader(
                        reference: image,
                        fit: BoxFit.cover,
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
                    height: Get.height / 1.2,
                  ),
                )),
            sb40(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthAdmin * 3),
              child: Button(
                height: EraTheme.buttonH60,
                text: 'LEARN MORE',
                fontSize: EraTheme.paragraphWeb,
                onTap: () {
                  Get.find<HomsController>().getBack = true.obs;
                  Get.to(ProjectViewWeb(),
                      binding: ProjectViewBinding(), arguments: project);
                  // projectArgument = project;

                  //    Get.to(ProjectViewWeb(),
                  // binding: ProjectViewBinding(), arguments: project);
                },
                bgColor: AppColors.kRedColor,
                borderRadius: BorderRadius.circular(30),
              ),
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
        fontSize: EraTheme.headerWeb,
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
        fontSize: EraTheme.paragraphWeb,
        fontWeight: FontWeight.w500,
        maxLines: 20,
      ),
    );
  }

  Widget infoTilePreview(
      String icon, TextEditingController controller, hintText, onChanged) {
    return Row(
      children: [
        Image.asset(icon, width: 100.w, height: 100.h),
        EraText(
          text: controller.text + hintText,
          // controller: controller,
          fontSize: 20.sp,
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
