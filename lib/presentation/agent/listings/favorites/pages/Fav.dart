import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_to_pdf_converter/image_to_pdf_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../app/constants/theme.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../../../../app/widgets/fav/favItems_widgets.dart';
import '../../../../../app/widgets/listings/agentInfo-widget.dart';
import '../../../../../app/widgets/sold_properties/custom_sort.dart';
import '../../../../../repository/listing.dart';
import '../../../../global.dart';
import '../controllers/fav_controller.dart';
//todo add text

class Fav extends GetView<FavController> {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.favState.value) {
                FavState.loading => _loading(),
                FavState.loaded => _loaded(),
                FavState.error => _error(),
                FavState.empty => _empty(),
                FavState.preview => _preview(),
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(() {
            if (controller.favoritesList.isEmpty) {
              return Center(child: Text('No favorites yet.'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: EraText(
                    text: 'MY FAVORITES',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomSortPopup(
                        title: 'Sort by',
                        onSelected: (String result) {
                          print(result);
                        },
                        menuItems: [
                          popMenu(text: 'Category',isActive: controller.sortBy.value == 'category',onTap: (){
                            controller.sortBy.value = 'category';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.sort((a,b)=> a.type!.compareTo(b.type!));
                            controller.favState.value = FavState.loaded;
                          }),
                          popMenu(text: 'Date',isActive: controller.sortBy.value == 'date',onTap: (){
                            controller.sortBy.value = 'date';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.sort((a,b)=> a.dateCreated!.compareTo(b.dateCreated!));
                            controller.favState.value = FavState.loaded;
                          }),
                          popMenu(text: 'Location',isActive: controller.sortBy.value == 'location',onTap: (){
                            controller.sortBy.value = 'location';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.sort((a,b)=> a.location!.compareTo(b.location!));
                            controller.favState.value = FavState.loaded;
                          }),
                          popMenu(text: 'Price',isActive: controller.sortBy.value == 'price',onTap: (){
                            controller.sortBy.value = 'price';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.sort((a,b)=> a.price!.compareTo(b.price!));
                            controller.favState.value = FavState.loaded;
                          }),
                          PopupMenuDivider(),
                          popMenu(text: 'Ascending',isActive: controller.sortOrder.value == 'asc',onTap: (){
                            controller.sortOrder.value = 'asc';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.value = controller.favoritesList.reversed.toList();
                            controller.favState.value = FavState.loaded;
                          }),
                          popMenu(text: 'Descending',isActive: controller.sortOrder.value == 'desc',onTap: (){
                            controller.sortOrder.value = 'desc';
                            controller.favState.value = FavState.loading;
                            controller.favoritesList.value = controller.favoritesList.reversed.toList();
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
                Column(
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
                                      controller.favState.value =
                                          FavState.preview;
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
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 150,
                          mainAxisSpacing: 5,
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
                                    Get.toNamed('/propertyInfo',
                                        arguments: controller.favoritesList[i]);
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
                )
              ],
            );
          }),
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
    return SizedBox(
      height: Get.height - 300.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
            ),
            EraText(
              fontSize: EraTheme.paragraph,
              text: "No Favorite Listings added!",
              color: Colors.black,
            ),
          ],
        ),
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
                    if (Platform.isAndroid) {
                      var androidInfo = await DeviceInfoPlugin().androidInfo;
                      var version = androidInfo.version.release.toInt();
                      if (version < 13) {
                        if (await Permission.storage.request().isGranted) {
                          downloadPDF();
                        }
                      } else {
                        if (await Permission.photos.request().isGranted) {
                          downloadPDF();
                        }
                      }
                    }
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
          height: Get.height - 275.h,
          child: preview(),
        )
      ],
    );
  }

  downloadPDF() async {
    final tempDir = await getTemporaryDirectory();
    List<File?> listOfFiles = [];
    for (var sc in controller.screenshotControllers) {
      var imageFile = File((await sc.captureAndSave(tempDir.path))!);
      listOfFiles.add(imageFile);
    }
    File a = await ImageToPdf.imageList(listOfFiles: listOfFiles);
    var pdfFileName =
        '${user!.firstname}_${user!.lastname}_${DateTime.now().microsecondsSinceEpoch}_listing.pdf';
    var downloadsFolder = Directory('/storage/emulated/0/Download');

    File pdfFile =
        await (await File('${downloadsFolder.path}/$pdfFileName').create())
            .writeAsBytes(await a.readAsBytes());
    //launchUrl(pdfFile.path); todo missy
    controller.showSuccessDialog(
        title: "Success",
        description: "PDF has been downloaded",
        hitApi: () {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
            id: Random().nextInt(1000),
            channelKey: 'download_channel',
            actionType: ActionType.Default,
            title: 'File Downloaded',
            body:
                'Pdf file has been downloaded, look for $pdfFileName at the download folder!',
          ));
          Get.back();
          Get.back();
        });
  }

  Widget preview() {
    return SizedBox(
      height: Get.height - 400.h,
      child: ListView.builder(
        itemCount: controller.selectedItems.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          Listing listing = controller.selectedListings[index];
          var sc = ScreenshotController();
          controller.screenshotControllers.add(sc);
          return Screenshot(
            controller: sc,
            child: Column(
              children: [
                index == 0
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
                  child: ListingItemss(
                    image: listing.photos?.first,
                    name: listing.name ?? "Test",
                    type: listing.type!,
                    areas: listing.area!,
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
                index != 0
                    ? SizedBox(
                        height: 130.h,
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
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
  popMenu({
    required String text,
    isActive = false,
    required onTap,
    style
  }){
    return PopupMenuItem<String>(
      onTap: onTap,
      value: text.toString().toLowerCase(),
      child: Obx((){
        controller.sortBy.value;
        controller.sortOrder.value;
        return Row(
          children: [
            isActive ? Row(
              children: [
                Icon(Icons.check,color: AppColors.blue,),
                SizedBox(width: 5.w,)
              ],
            ) : Container(),
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
