import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/presentation/website/listings/pages/favorites/controllers/fav_controller.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../../app/constants/screens.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as web;
import '../../../../../../app/constants/theme.dart';
import '../../../../../../app/widgets/fav/favItems_widgets.dart';
import '../../../../../../app/widgets/listings/agentInfo-widget.dart';
import '../../../../../../app/widgets/listings/listing_items_web.dart';
import '../../../../../../app/widgets/sold_properties/custom_sort.dart';
import '../../../../../../repository/listing.dart';
import '../../../../../global.dart';
import '../../../../landingpage/controller/homs_controller.dart';
//todo add text

class FavWeb extends GetView<FavWebController> {
  const FavWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(FavWebController());
    return SafeArea(
      child: Obx(
        () => switch (controller.favState.value) {
          FavState.loading => _loading(),
          FavState.loaded => _loaded(),
          FavState.error => _error(),
          FavState.empty => _empty(),
          FavState.preview => _preview(),
        },
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              EraText(
                text: 'MY FAVORITES',
                fontSize: EraTheme.h2,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomSortPopup(
                  title: 'Sort by',
                  onSelected: (String result) {
                    print(result);
                  },
                  menuItems: [
                    popMenu(
                        text: 'Category',
                        isActive: controller.sortBy.value == 'category',
                        onTap: () {
                          controller.sortBy.value = 'category';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList
                              .sort((a, b) => a.type!.compareTo(b.type!));
                          controller.favState.value = FavState.loaded;
                        }),
                    popMenu(
                        text: 'Date',
                        isActive: controller.sortBy.value == 'date',
                        onTap: () {
                          controller.sortBy.value = 'date';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList.sort((a, b) =>
                              a.dateCreated!.compareTo(b.dateCreated!));
                          controller.favState.value = FavState.loaded;
                        }),
                    popMenu(
                        text: 'Location',
                        isActive: controller.sortBy.value == 'location',
                        onTap: () {
                          controller.sortBy.value = 'location';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList.sort(
                              (a, b) => a.location!.compareTo(b.location!));
                          controller.favState.value = FavState.loaded;
                        }),
                    popMenu(
                        text: 'Price',
                        isActive: controller.sortBy.value == 'price',
                        onTap: () {
                          controller.sortBy.value = 'price';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList
                              .sort((a, b) => a.price!.compareTo(b.price!));
                          controller.favState.value = FavState.loaded;
                        }),
                    PopupMenuDivider(),
                    popMenu(
                        text: 'Ascending',
                        isActive: controller.sortOrder.value == 'asc',
                        onTap: () {
                          controller.sortOrder.value = 'asc';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList.value =
                              controller.favoritesList.reversed.toList();
                          controller.favState.value = FavState.loaded;
                        }),
                    popMenu(
                        text: 'Descending',
                        isActive: controller.sortOrder.value == 'desc',
                        onTap: () {
                          controller.sortOrder.value = 'desc';
                          controller.favState.value = FavState.loading;
                          controller.favoritesList.value =
                              controller.favoritesList.reversed.toList();
                          controller.favState.value = FavState.loaded;
                        }),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                _pdfButton()
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return controller.selectionModeActive.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  for (var selected
                                      in controller.selectedItems) {
                                    controller.selectedListings.add(
                                        controller.favoritesList[selected]);
                                  }
                                  controller.favState.value = FavState.preview;
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: BorderSide(color: AppColors.hint),
                                  backgroundColor: AppColors.white,
                                  elevation: 2,
                                ),
                                label: Obx(() {
                                  return EraText(
                                    text:
                                        'GENERATE PDF ( ${controller.selectedCount.value} selected )',
                                    color: AppColors.blue,
                                  );
                                })),
                            SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {
                                controller.exitSelectionMode();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(color: AppColors.hint),
                                backgroundColor: AppColors.white,
                                elevation: 2,
                              ),
                              label: EraText(
                                text: 'CANCEL',
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                }),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                    ),
                    itemCount: controller.favoritesList.length,
                    itemBuilder: (context, i) => Obx(() {
                      return Stack(
                        children: [
                          FavItems(
                            listing: controller.favoritesList[i],
                            index: i,
                            onTap: () {
                              if (controller.selectionModeActive.value) {
                                controller.toggleSelection(i);
                              } else {
                                listingArgument = controller.favoritesList[i];
                                selectedIndex.value = 10;
                                Get.find<HomsController>()
                                    .onNavbarItemSelected(10);
                              }
                            },
                            onLongPress: (index) {
                              controller.toggleSelection(index);
                            },
                          ),
                          if (controller.selectionModeActive.value)
                            GestureDetector(
                              onTap: () => controller.toggleSelection(i),
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius: controller.isSelected(i)
                                    ? BorderRadius.circular(10)
                                    : null,
                                border: Border.all(
                                  color: controller.isSelected(i)
                                      ? AppColors.kRedColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              )),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _error() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "Something went Wrong!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _empty() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                    size: 20.sp,
                  )),
            ],
          ),
          Center(
            child: EraText(
              text: "No Favorite Listings added!",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _preview() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidth, vertical: 11.w),
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 230.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    controller.showLoading();
                    downloadPDF();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.5.w),
                    decoration: BoxDecoration(
                        color: AppColors.kRedColor,
                        borderRadius: BorderRadius.circular(7.5)),
                    width: 140.w,
                    child: EraText(
                      color: Colors.white,
                      text: "Download",
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.favState.value = FavState.loaded;
                  },
                  child: SizedBox(
                    width: 75.w,
                    child: EraText(
                      textDecoration: TextDecoration.underline,
                      color: AppColors.kRedColor,
                      text: "Cancel",
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          // height: Get.height - 275.h,
          child: preview(),
        )
      ],
    );
  }

  downloadPDF() async {
    // final tempDir = await getTemporaryDirectory();
    List<File?> listOfFiles = [];
    final pdf = pw.Document();
    print(controller.screenshotControllers.length);
    for (var sc in controller.screenshotControllers) {
      var a = await sc.capture();
      if (a != null) {
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Image(pw.MemoryImage(a));
        }));
      }
    }
    // File a = await ImageToPdf.;
    var pdfFileName =
        '${user!.firstname}_${user!.lastname}_${DateTime.now().microsecondsSinceEpoch}_listing.pdf';
    // var downloadsFolder = Directory('/storage/emulated/0/Download');

    // File pdfFile =
    //     await (await File('${downloadsFolder.path}/$pdfFileName').create())
    //         .writeAsBytes(await a.readAsBytes());
    //launchUrl(pdfFile.path);
    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    web.AnchorElement()
      ..href =
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}"
      ..setAttribute("download", pdfFileName)
      ..click();
    controller.showSuccessDialog(
        title: "Success",
        description: "PDF has been downloaded",
        hitApi: () {
          Get.back();
          Get.back();
        });
  }

  Widget preview() {
    controller.screenshotControllers.clear();
    var sc = ScreenshotController();
    controller.screenshotControllers.add(sc);
    return Builder(
      builder: (context) {
        List<Widget> widgets = [];
        List<Widget> tempWidgets = [];
        for (int i = 0; i < controller.selectedListings.length; i++) {
          Listing listing = controller.selectedListings[i];
          tempWidgets.length >= 2 ? tempWidgets.clear() : null;
          tempWidgets.add(Column(
            children: [
              i == 0
                  ? (Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidth),
                        child: AgentInfoWidget.agentInformation(
                          imageProvider: user!.image != null
                              ? user!.image!
                              : AppStrings.noUserImageWhite,
                          firstName: '${user!.firstname}',
                          lastName: '${user!.lastname}',
                          whatsApp: '${user!.whatsApp}',
                          email: '${user!.email}',
                          role: '${user!.role}',
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ]))
                  : Container(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5.h),
                padding:
                    EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                child: ListingItemsWeb(
                  image: listing.photos?.first,
                  name: listing.name ?? "Test",
                  type: listing.type!,
                  areas: listing.floorArea!,
                  beds: listing.beds ?? 0,
                  baths: listing.baths ?? 0,
                  cars: listing.cars ?? 0,
                  price: listing.price ?? 0,
                  description: listing.description ?? "No description added!",
                  showListedby: false,
                  isSold: listing.isSold ?? false,
                  fromSold: false,
                ),
              ),
              i > 1 && i + 1 % 2 == 0
                  ? SizedBox(
                      height: 230.h,
                    )
                  : Container()
            ],
          ));
          if ((i + 1) % 2 == 0) {
            var sc = ScreenshotController();
            controller.screenshotControllers.add(sc);
            widgets.add(Screenshot(
              controller: sc,
              child: Column(
                children: tempWidgets,
              ),
            ));
          }
        }
        return Column(children: widgets);
      },
    );
  }

  Widget _sortByButton() {
    return PopupMenuButton<String>(
      color: AppColors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.blue),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      icon: EraText(
        text: 'Sort by',
        color: AppColors.white,
        fontSize: 15.sp,
      ),
      onSelected: (String result) {
        print(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Category',
          child: EraText(text: 'Category', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'date_modified',
          child: EraText(text: 'Date', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'Location',
          child: EraText(text: 'Location', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'Amount',
          child: EraText(text: 'Amount', color: AppColors.black),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'ascending',
          child: Text('Ascending'),
        ),
        const PopupMenuItem<String>(
          value: 'descending',
          child: Text('Descending'),
        ),
      ],
    );
  }

  popMenu({required String text, isActive = false, required onTap, style}) {
    return PopupMenuItem<String>(
      onTap: onTap,
      value: text.toString().toLowerCase(),
      child: Obx(() {
        controller.sortBy.value;
        controller.sortOrder.value;
        return Row(
          children: [
            isActive
                ? Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.blue,
                      ),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  )
                : Container(),
            Text(
              text,
              style: style ?? TextStyle(),
            )
          ],
        );
      }),
    );
  }

  Widget _pdfButton() {
    return GestureDetector(
      onTap: () {
        controller.onGeneratePdfButtonPressed();
      },
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.kRedColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: EraText(
              text: 'Generate PDF',
              color: AppColors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
