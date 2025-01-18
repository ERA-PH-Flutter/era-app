import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/agent/forms/contacts/controllers/contacts_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../app/services/firebase_storage.dart';
import '../../../../../app/widgets/button.dart';
import '../../../../../app/widgets/custom_appbar.dart';

class JoinEra extends GetView<ContactusController> {
  const JoinEra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: WillPopScope(
        onWillPop: () async {
          // selectedIndex.value = 0;
          // pageViewController = PageController(initialPage: 0);
          // currentRoute = '/home';
          // Get.offAll(BaseScaffold(),binding: HomeBinding());
          Get.back();
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('cms')
                      .doc('find_agents')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.data()!;
                      if (data['type'] == "image") {
                        return CloudStorage().imageLoader(
                            reference: data['link'],
                            fit: BoxFit.cover,
                            width: Get.width);
                      } else if (data['type'] == "youtube") {
                        var url = data['link'].toString();
                        String? videoUrl = YoutubePlayer.convertUrlToId(url);
                        controller.youtubePlayerController =
                            YoutubePlayerController(
                          initialVideoId: videoUrl!,
                          flags: YoutubePlayerFlags(
                            enableCaption: false,
                            autoPlay: false,
                            mute: false,
                            forceHD: true,
                          ),
                        );
                        return YoutubePlayer(
                          controller: controller.youtubePlayerController,
                          bottomActions: const [
                            CurrentPosition(),
                            ProgressBar(isExpanded: true),
                            RemainingDuration(),
                          ],
                        );
                      }
                      //  else if (data['type'] == "video") {
                      //   return FutureBuilder(
                      //       future: FirebaseStorage.instance
                      //           .ref(data['link'])
                      //           .getDownloadURL(),
                      //       builder: (context, snapshot) {
                      //         if (snapshot.hasData) {
                      //           var videoController =
                      //               VideoPlayerController.networkUrl(
                      //                   Uri.parse(snapshot.data!));
                      //           return videoController.value.isInitialized
                      //               ? AspectRatio(
                      //                   aspectRatio:
                      //                       videoController.value.aspectRatio,
                      //                   child: VideoPlayer(videoController),
                      //                 )
                      //               : Container();
                      //         }
                      //         return Center(
                      //           child: CircularProgressIndicator(),
                      //         );
                      //       });
                      // }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: EraText(
                      text: 'Join Us Today',
                      fontSize: EraTheme.header - 4.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kRedColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildDescription(
                    'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
                SizedBox(
                  height: 20.h,
                ),
                _buildDescription(
                    'ERA Real Estate was founded on the principle of collaboration.'),
                _buildDescription(
                    'The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
                SizedBox(
                  height: 20.h,
                ),
                _buildDescription('Why Join Us?',
                    color: AppColors.blue,
                    fontSize: EraTheme.header - 4.sp,
                    fontWeight: FontWeight.w600),
                _buildDescription('•   Training & Development'),
                _buildDescription('•   Reputable developer properties'),
                _buildDescription('•   Favourable Commission Terms'),
                _buildDescription('•   Advanced Digital Platforms'),
                _buildDescription('•   Administrative Support'),
                _buildDescription(
                    '•   Access to our office spaces & facilities'),
                sb30(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  width: Get.width,
                  child: Button(
                    borderRadius: BorderRadius.circular(99),
                    onTap: () {
                      Get.toNamed(RouteString.termsAndConditions);
                    },
                    height: 53.h,
                    width: Get.width,
                    text: "Get Started",
                    fontSize: EraTheme.paragraph,
                    bgColor: AppColors.kRedColor,
                  ),
                ),
                sb10(),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ),
                sb50(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        children: [
          EraText(
              text: text,
              maxLines: 50,
              fontSize: fontSize ?? EraTheme.paragraph,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? AppColors.black),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }

  Widget text(String text) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: EraText(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              maxLines: 50,
            )),
      ],
    );
  }
}
