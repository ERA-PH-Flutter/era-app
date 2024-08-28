import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/contacts/pages/direct-contactus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class Help extends GetView<ContactusController> {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'FAQs',
                fontSize: 25.sp,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'Account Name,\nWhat do you want to know?',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              BoxWidget.build(
                  child: Column(
                children: [
                  AppTextField(
                    hint: 'AI Search',
                    svgIcon: AppEraAssets.send,
                    bgColor: AppColors.white,
                  ),
                  SizedBox(height: 10.h),
                  SearchWidget.build(() {}),
                ],
              )),
              SizedBox(height: 20.h),
              EraText(
                text: 'GENERAL',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('What is ERA Philippines?',
                  'ERA Philippines is a premier real estate agency offering a wide range of property services, including buying, selling, and renting properties'),
              SizedBox(height: 15.h),
              expansionTile('What services does ERA Philippines offer?',
                  'We offer a comprehensive range of real estate services, including property sales, leasing, and property management.'),
              SizedBox(height: 15.h),
              expansionTile(
                  'How can I sign up for the ERA Philippines web app?',
                  'You can sign up by clicking the "Sign Up" button on the homepage and filling in the required information, such as your name, email, and contact number.'),
              SizedBox(height: 15.h),
              expansionTile('Is the ERA Philippines app free to use?',
                  'Yes, the basic features of the ERA Philippines web app are free to use.'),
              SizedBox(height: 15.h),
              expansionTile('How often are the real estate listings updated?',
                  'Our real estate listings are updated daily to ensure you have the latest information on available properties.'),
              SizedBox(height: 15.h),
              SizedBox(height: 20.h),
              EraText(
                text: 'Account Management',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('How do I reset my password?',
                  'Click on the "Forgot Password" link on the login page, enter your email address, and follow the instructions sent to your email to reset your password.'),
              SizedBox(height: 15.h),
              expansionTile('How can I update my profile information?',
                  'After logging in, go to the "Profile" section in the menu. Here, you can update your personal details, contact information, and profile picture.'),
              SizedBox(height: 15.h),
              expansionTile('How can I delete my account?	',
                  'Please contact our support team via the "Contact Us" page to request account deletion. They will guide you through the process.'),
              SizedBox(height: 20.h),
              EraText(
                text: 'Property Listings',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('How do I search for properties on the web app?',
                  'Use the search bar on the homepage to enter your criteria, such as location, price range, and property type. You can also use advanced filters for more specific searches.'),
              SizedBox(height: 15.h),
              expansionTile('How can I list my property for sale or rent?',
                  'Go to the "List Property" section in the menu, fill in the necessary details about your property, and upload high-quality images. Your listing will be reviewed and published within 24-48 hours.'),
              SizedBox(height: 15.h),
              expansionTile(
                  'How can I contact a seller or agent for a property I\'m interested in?',
                  'Click on the property listing to view details. You’ll find the seller\'s or agent\'s contact information and an option to send a direct message or request a callback.'),
              SizedBox(height: 20.h),
              EraText(
                text: 'Support',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('How can I contact customer support?',
                  'You can reach our customer support team via the "Contact Us" page, through email at eraph@gmail.com, or by calling our hotline at +639177710572'),
              SizedBox(height: 15.h),
              expansionTile(
                  'What should I do if I encounter a technical issue on the web app?',
                  'Please report any technical issues via the "___________" section or contact our support team. Provide as much detail as possible for a quicker resolution.'),
              SizedBox(height: 20.h),
              EraText(
                text: 'Property Viewing',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('Can I schedule a property viewing online?', ''),
              SizedBox(height: 20.h),
              EraText(
                text: 'Legal and Documentation',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('What documents are required to buy a property?',
                  'Commonly required documents include a valid ID, proof of income, and bank statements. Specific requirements may vary based on the property and your financial situation.'),
              SizedBox(height: 20.h),
              EraText(
                text: 'Agent Services',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('How can I find a real estate agent in my area?',
                  'You can find experienced real estate agents by navigating to our "Find an Agent" page, where you can search by location and expertise.'),
              SizedBox(height: 20.h),
              EraText(
                text: 'Notifications',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile('How do I manage notifications and alerts?', ''),
              SizedBox(height: 20.h),
              EraText(
                text: 'Reviews and Ratings',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 20.h),
              expansionTile(
                  'Can I leave a review for a property or an agent?', ''),
              SizedBox(
                height: 20.h,
              ),
              iconButton(
                padding: EdgeInsets.only(right: 30.w),
                icon: AppEraAssets.whatsappIcon,
                text: 'WhatsApp',
                text1: 'Email',
                icon2: AppEraAssets.emailIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget iconButton({
    required String text,
    required String icon,
    required String text1,
    required String icon2,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              //direct to whatsapp so it's fixed
            },
            child: Row(
              children: [
                Image.asset(
                  icon,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: text,
                  fontSize: 18.sp,
                  color: AppColors.black,
                  textDecoration: TextDecoration.underline,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40.w,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/direct-contactus");
            },
            child: Row(
              children: [
                Image.asset(
                  icon2,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: text1,
                  fontSize: 18.sp,
                  color: AppColors.black,
                  textDecoration: TextDecoration.underline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget expansionTile(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.hint.withOpacity(0.1),
        collapsedBackgroundColor: AppColors.hint.withOpacity(0.1),
        title: EraText(
          text: title,
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        children: [
          ListTile(
            title: EraText(
              text: content,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              maxLines: 50,
            ),
          ),
        ],
      ),
    );
  }
}
