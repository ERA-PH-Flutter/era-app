import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../app/widgets/custom_appbar.dart';
import '../../forms/contacts/pages/findus.dart';
import '../../forms/contacts/pages/inquiry.dart';
import '../controllers/projects_controller.dart';

class HarayaProject extends GetView<ProjectsController> {
  const HarayaProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: ProjectsModels1.projects.map((project) {
              return projectContainer(project);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget projectContainer(ProjectsModels1 project) {
    return Column(
      children: [
        Image.asset(project.heroImage!),
        SizedBox(height: 15.h),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        SizedBox(height: 15.h),
        CarouselSliderWidget(images: CarouselModels.carouselModels),
        SizedBox(height: 30.h),
        projectContent1(project),
        SizedBox(height: 30.h),
        projectContent2(project),
        SizedBox(height: 50.h),
        projecContent3(project),
        projectContent4(project),
        SizedBox(height: 30.h),
        projectContent5(project),
        SizedBox(height: 30.h),
        paddingText(
          project.text34 ?? "",
          18.sp,
          FontWeight.w700,
          AppColors.blue,
          45,
        ),
        SizedBox(height: 10.h),
        paddingText(
          project.text35 ?? "",
          14.sp,
          FontWeight.w500,
          AppColors.black,
          45,
        ),
        SizedBox(height: 10.h),
        Builder(builder: (context) {
          var webViewController = WebViewController();
          var params = const PlatformWebViewControllerCreationParams();
          WebViewController.fromPlatformCreationParams(
            params,
            onPermissionRequest: (WebViewPermissionRequest request) {
              request.grant();
            },
          );

          webViewController
            //..runJavaScript("document.querySelector('head').innerHTML += '<meta http-equiv=\"Content-Security-Policy\" content=\"script-src 'none' 'unsafe-eval'\">';",)
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (String url) {
                  controller.isLoading.value = true;
                },
                onPageFinished: (String url) {
                  controller.isLoading.value = false;
                },
                onWebResourceError: (WebResourceError error) {},
              ),
            )
            ..loadRequest(Uri.parse(
                'https://livetour.istaging.com/ba0d3366-5267-4209-af73-a8841381dc44'));
          return SizedBox(
            height: 400.h,
            child: GestureDetector(
              child: WebViewWidget(
                controller: webViewController,
              ),
            ),
          );
        }),
        SizedBox(height: 15.h),
        Inquiry(),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: FindUs(),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget projectContent1(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.0.h),
      color: AppColors.hint.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paddingText(
            project.text1!,
            20,
            FontWeight.bold,
            AppColors.blue,
            15,
          ),
          paddingText(
            project.text2!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            20,
          ),
          SizedBox(height: 10.h),
          paddingText(
            project.text3!,
            14,
            FontWeight.w500,
            AppColors.black,
            20,
          ),
          SizedBox(height: 10.h),
          Builder(builder: (context) {
            var webViewController = WebViewController();
            var params = const PlatformWebViewControllerCreationParams();
            WebViewController.fromPlatformCreationParams(
              params,
              onPermissionRequest: (WebViewPermissionRequest request) {
                request.grant();
              },
            );

            webViewController
              //..runJavaScript("document.querySelector('head').innerHTML += '<meta http-equiv=\"Content-Security-Policy\" content=\"script-src 'none' 'unsafe-eval'\">';",)
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageStarted: (String url) {
                    controller.isLoading.value = true;
                  },
                  onPageFinished: (String url) {
                    controller.isLoading.value = false;
                  },
                  onWebResourceError: (WebResourceError error) {},
                ),
              )
              ..loadRequest(Uri.parse(
                  'https://livetour.istaging.com/d648d3c2-86bb-4f1d-9224-ff37d99c6d69'));
            return SizedBox(
              height: 400.h,
              child: GestureDetector(
                child: WebViewWidget(
                  controller: webViewController,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget projectContent2(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: project.text4 ?? "",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Image.asset(
            project.image2 ?? "",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text5 ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text6 ?? "",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          Image.asset(
            project.image3 ?? "",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text7 ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
        ],
      ),
    );
  }

  Widget projecContent3(ProjectsModels1 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          EraText(
            text: project.text8 ?? "",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text9 ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image4 ?? ""),
          SizedBox(height: 20.h),
          EraText(
            text: project.text10 ?? "",
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text11 ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image5 ?? ""),
          SizedBox(height: 30.h),
          Image.asset(project.image6 ?? ""),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget projectContent4(project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: project.text12,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: project.text13,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image7),
          SizedBox(height: 10.h),
          EraText(
            text: project.text14,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text15,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          Image.asset(project.image8),
          SizedBox(height: 10.h),
          EraText(
            text: project.text16,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: project.text17,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            maxLines: 50,
          ),
        ],
      ),
    );
  }

  Widget projectContent5(ProjectsModels1 project) {
    return Container(
      //horizontal: 25.w,
      padding: EdgeInsets.symmetric(vertical: 15.0.h),
      color: AppColors.hint.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paddingText(
            project.text18!,
            20.sp,
            FontWeight.bold,
            AppColors.blue,
            40.sp,
          ),
          paddingText(
            project.text19!,
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          carouselSliderWidget2(CarouselModels.carouselModels),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoTile(project.icons!, project.text20!),
                infoTile(project.icons1!, project.text21!),
                infoTile(project.icons2!, project.text22!),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          paddingText(
            project.text23 ?? "",
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45.sp,
          ),
          SizedBox(height: 20.h),
          paddingText(
            project.text24 ?? "",
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          carouselSliderWidget2(CarouselModels.carouselModels),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoTile(project.icons ?? "", project.text25 ?? ""),
                infoTile(project.icons1 ?? "", project.text26 ?? ""),
                infoTile(project.icons2 ?? "", project.text27 ?? ""),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          paddingText(
            project.text23 ?? "",
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45.sp,
          ),
          SizedBox(height: 20.h),
          paddingText(
            project.text29 ?? "",
            18.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            45.sp,
          ),
          SizedBox(height: 15.h),
          carouselSliderWidget2(CarouselModels.carouselModels),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                infoTile(project.icons ?? "", project.text30 ?? ""),
                infoTile(project.icons1 ?? "", project.text31 ?? ""),
                infoTile(project.icons2 ?? "", project.text32 ?? ""),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          paddingText(
            project.text33 ?? "",
            14.sp,
            FontWeight.w500,
            AppColors.black,
            45,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  static Widget infoTile(String icon, String value) {
    return Row(
      children: [
        Image.asset(icon, width: 70.w, height: 70.h),
        EraText(
          text: value,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black.withOpacity(0.9),
        ),
      ],
    );
  }

  static Widget paddingTextTitle(String text, double fontSize,
      FontWeight fontWeight, Color color, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding.w,
      ),
      child: EraText(
        text: text,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        maxLines: 50,
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget paddingText(String text, double fontSize, FontWeight fontWeight,
      Color color, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding.w,
      ),
      child: EraText(
        text: text,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        maxLines: 50,
      ),
    );
  }

  Widget shortText(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: text,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          maxLines: 50,
        ),
      ],
    );
  }

  static Widget carouselSliderWidget2(List<String> images) {
    return Stack(
      children: [
        CarouselSlider(
          items: images.map((images) {
            return Builder(builder: (BuildContext context) {
              return CustomImage(
                url: images,
                borderradius: 30,
              );
            });
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
        ),
      ],
    );
  }
}
