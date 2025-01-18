import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/screens.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/authentication/controller/authentication_controller.dart';
import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/button.dart';

import '../../authentication/pages/create_account_web.dart';
import '../controllers/form_web_controller.dart';

class JoinEraWeb extends GetView<FormWebController> {
  const JoinEraWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.kRedColor,
                    AppColors.kRedColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                    right: -70,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('cms')
                            .doc('about_us')
                            .get(),
                        builder: (contect, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data();
                            return CloudStorage().imageLoader(
                              reference: data!['photo'],
                              height: Get.height * 0.6,
                              width: Get.width * 0.85,
                              fit: BoxFit.cover,
                            );
                          }
                          return Screens.loading();
                        })

                    // Image.network(
                    //   'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                    //   fit: BoxFit.cover,
                    //   height: Get.height * 0.6,
                    //   width: Get.width * 0.85,
                    // ),
                    ),
              ),
            ),
            Positioned(
              bottom: 100.h,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EraText(
                    text: 'Join ERA Today!',
                    fontSize: EraTheme.h1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  EraText(
                    text:
                        'Be part of an international brand with 2,390 offices globally.',
                    fontSize: EraTheme.h6,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.7),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.h),
                  Button(
                    text: "Get Started",
                    fontSize: EraTheme.h6,
                    onTap: () {
                      showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none),
                                insetPadding: EdgeInsets.symmetric(
                                    horizontal: EraTheme.paddingWidthAdmin * 6,
                                    vertical: EraTheme.paddingWidthAdmin * 2),
                                backgroundColor: AppColors.white,
                                child: Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: AppColors.white,
                                    surfaceTintColor: AppColors.white,
                                    automaticallyImplyLeading: false,
                                    centerTitle: true,
                                    title: EraText(
                                      text: 'Terms and Conditions',
                                      fontSize: EraTheme.paragraphWeb,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                    scrolledUnderElevation: 4,
                                    toolbarHeight: 100.h,
                                    elevation: 0,
                                  ),
                                  body: Stack(
                                    children: [
                                      // SliverAppBar(),
                                      CustomScrollView(
                                        controller: controller.scrollController,
                                        slivers: [
                                          SliverToBoxAdapter(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    EraTheme.paddingWidthAdmin -
                                                        10.sp,
                                              ),
                                              child: termsAndConditionWidget(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: BottomAppBar(
                                          color: AppColors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => Button(
                                                  text: 'Accept',
                                                  color: AppColors.blue,
                                                  width: Get.width / 5,
                                                  onTap: controller
                                                          .isAtBottom.value
                                                      ? () {
                                                          AuthenticationWebController
                                                              controllerAuth =
                                                              Get.put(
                                                                  AuthenticationWebController());
                                                          // Get.toNamed(RouteString
                                                          //     .createaccountweb);
                                                          createAccountWeb(
                                                              controller:
                                                                  controllerAuth);
                                                        }
                                                      : null,

                                                  fontSize:
                                                      EraTheme.paragraphWeb,

                                                  bgColor: controller
                                                          .isAtBottom.value
                                                      ? AppColors.white
                                                      : AppColors.hint
                                                          .withOpacity(0.2),
                                                  // borderSide: BorderSide(color: AppColors.blue),
                                                  border: Border.all(
                                                      color: AppColors.blue),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              sbw20(),
                                              Button(
                                                text: 'Decline',
                                                width: Get.width / 5,
                                                fontSize: EraTheme.paragraphWeb,
                                                onTap: () {
                                                  Get.back();
                                                },
                                                bgColor: AppColors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    bgColor: Colors.white,
                    color: AppColors.kRedColor,
                    borderRadius: BorderRadius.circular(30),
                    width: 200.w,
                  ),
                  //       _buildRichText(),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb15(),
              //text era
              _buildTextJoinEra(),
              sb50(),
              EraText(
                text: 'About Us',
                fontSize: EraTheme.h1,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              sb20(),
              _buildDescription(
                'Welcome to a new ERA of property discovery and management.',
              ),

              sb40(),
              _buildDescription(
                  'ERA Real Estate Philippines is a proud member of ERA Real Estate, the largest real estate network in the Asia-Pacific region with more than 23,400 trusted advisers in over 640 offices across 13 countries. We provide exceptional real estate services, guiding you through buying, selling, and investing.'),
              sb40(),
              _buildDescription(
                  'We envision a world where searching for and managing real estate is as simple as a few taps on your phone. With the ERA Real Estate Philippines app, we aim to redefine the property landscape in the Philippines by providing cutting-edge tools and resources that enable you to make informed decisions with confidence.'),
              sb40(),
              _buildDescription(
                  'At ERA Real Estate Philippines, we empower you to achieve your real estate dreams. Discover the ERA difference today!'),
              sb50(),
              EraText(
                text: 'What We Do',
                fontSize: EraTheme.h1,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              sb30(),
              _buildServices(),
              sb40(),

              AboutUsWeb.buildJoinUsSection(),

              sb50(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextJoinEra() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb50(),
        EraText(
            textAlign: TextAlign.start,
            text: 'Join Us Today!',
            fontSize: EraTheme.headerWeb,
            fontWeight: FontWeight.w600,
            color: AppColors.kRedColor),
        sb40(),
        _buildDescription(
            'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
        sb40(),
        _buildDescription(
            'ERA Real Estate was founded on the principle of collaboration.'),
        _buildDescription(
            'The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
      ],
    );
  }

  Widget _buildRichText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By continuing, you agree to our ',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: EraTheme.paragraphWeb - 10.sp,
              ),
              children: [
                TextSpan(
                  text: 'Terms',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return EraText(
        textAlign: TextAlign.start,
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.black);
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

  Widget termsAndConditionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(text: '1. Privacy Commitment'),
        sb10(),
        paragraph(
            'Regarding the handling, storage, and dissemination of Personal Data, ERA Philippines is committed to safeguarding privacy and upholding data security. In alignment with this commitment, our leadership, team, and employees endeavor to protect the confidentiality and integrity of all Personal Information we manage in conformity with the Data Privacy Act of 2012 (Philippines). We strive to ensure all processes involving the acquisition, storage, sharing, and application of Personal Data, whether conducted by ERA Philippines or our approved partners, adhere to our stringent Privacy Policy standards.\n\nBy interacting with ERA Philippines, submitting details to us, or utilizing the real estate services we offer, you, the client, consent to allowing ERA Philippines, inclusive of our representatives, salespeople, and agents, to collect, apply, reveal, and exchange your Personal Data as described. This also includes the authorization for ERA Philippines to provide your Personal Information to approved service providers and pertinent third parties as outlined by our policy.'),
        sb40(),
        title(text: '2. Collection of Personal Information'),
        sb10(),
        paragraph(
            '2.1 In the course of its regular operations, ERA Philippines may gather Personal Data from you through various channels, including: providing your contact information during attendance at our marketing events; leaving your contact details or expressing interest in viewing a property during visits to our showflats; interacting with our salespersons or agents through telephone calls, letters, in-person meetings, or email correspondences; responding to our marketing materials; enlisting the assistance of our salespersons or agents in property transactions such as sales, purchases, or rentals; receiving referrals from business partners and third parties; and when you submit your Personal Data to us for any other purposes.\n'),
        sb10(),
        paragraph(
            '2.2 ERA Philippines commits to maintaining the highest standards of privacy and data protection. In our dealings, we may collect various types of Personal Information to better serve your needs and comply with applicable laws, including, but not limited to:\n'),
        subHeader(
            'Basic Personal Information: Name, Address, Date of Birth, Nationality, Gender, and Marital Status.'),
        sb10(),
        subHeader(
            'Contact Information: Phone numbers, email addresses, and mailing addresses.'),
        sb10(),
        subHeader(
            'Financial Information: Bank account details, income levels, credit history, and financial statements, essential for facilitating transactions and assessing eligibility for financing.'),
        sb10(),
        subHeader(
            'Property Preferences: Information regarding your preferences for residential or commercial properties, investment interests, and other details pertinent to your real estate inquiries. '),
        sb10(),
        subHeader(
            'Identification Documents: Copies of government-issued identification (e.g., Passport, Driver’s License, SSS ID), required for verification purposes and to ensure compliance with the Anti-Money Laundering Act (AMLA). '),
        sb10(),
        subHeader(
            'Online Activity Data: Website usage, preferences, and interactions captured through cookies and similar technologies to enhance your online experience and provide personalized services.\n'),
        sb10(),
        paragraph(
            '2.3 Consent for Third-party Personal Information.\nWhen you provide us with Personal Information of third parties (e.g., co-buyers, dependents), it is your responsibility to ensure that they are aware of this fact and have consented to their data being shared with us for the purposes outlined.\n'),
        paragraph(
            '2.4 Your Rights and Consent In line with the Data Privacy Act of 2012, we emphasize your rights over your Personal Information, including the right to access, correct, and object to the processing of your data. We are committed to obtaining your explicit consent before collecting any Personal Information, with a clear explanation of its intended use and safeguarding measures.'),
        paragraph(
            '\nBy engaging with ERA Philippines, you acknowledge your consent to this policy. Should you wish to modify your consent or inquire about your Personal Information, our dedicated privacy team is at your disposal to assist with any requests.'),
        sb40(),
        title(text: '3. Objectives for Gathering Personal Information'),
        sb10(),
        paragraph(
            '3.1 The Personal Data mentioned in Paragraph 2.2 above is collected for the purposes of:\n'),
        subHeader(
            'Serving as your accredited real estate representative for transactions involving buying, selling, or leasing properties.'),
        sb10(),
        subHeader(
            'Keeping clients informed about upcoming real estate projects, as well as other property opportunities that might meet their preferences, or existing properties up for sale or lease.'),
        sb10(),
        subHeader(
            'Engaging with clients who have shown an interest in acquiring or leasing properties.'),
        sb10(),
        subHeader(
            'Facilitating client reservations for units in new property launches.'),
        sb10(),
        subHeader('Evaluating property worth utilizing de-identified data.'),
        sb10(),
        subHeader(
            'Undertaking market studies and analyses with de-identified data.'),
        sb10(),
        subHeader('Producing billing statements.'),
        sb10(),
        subHeader('Complying with legal mandates.\n'),
        paragraph(
            '3.2 Furthermore, ERA Philippines undertakes the collection of your Personal Information when you submit an application for either employment or for becoming a real estate salesperson or agent for reasons such as:\n'),
        subHeader(
            'Processing your application, which involves performing preliminary checks concerning your qualifications and professional history.'),
        sb10(),
        subHeader(
            'Securing or providing references for employment and executing background checks or due diligence processes.'),
        sb10(),
        subHeader(
            'Compiling information to evaluate your aptness for the position applied.'),
        sb10(),
        subHeader(
            'Communicating with you as deemed necessary in accordance with the policies and protocols of ERA Philippines, including those relevant to operational continuity.'),
        sb10(),
        subHeader(
            'Any related purposes connected to the above-mentioned activities.'),
        sb40(),
        title(text: '4. Disclosure of Personal Data'),
        sb10(),
        paragraph(
            '4.1 In accordance with the principles set forth and without limiting the scope of previously mentioned points, your Personal Data may be shared with the following entities:\n'),
        subHeader('Business partners'),
        sb10(),
        subHeader('Property developers'),
        sb10(),
        subHeader('Associated brokers'),
        sb10(),
        subHeader('Insurance providers (pertaining to group policies'),
        sb10(),
        subHeader('Law enforcement bodies'),
        sb10(),
        subHeader('Government entities'),
        sb10(),
        subHeader('Regulatory organizations'),
        sb10(),
        subHeader('Legal counsel'),
        sb10(),
        subHeader('Auditing services'),
        sb10(),
        subHeader('External consultants and service providers'),
        sb10(),
        subHeader(
            'Any real estate agent or salesperson operating under the banner of ERA Philippines to deliver the services offered by ERA Philippines.\n'),
        paragraph(
            '4.2 ERA Philippines reserves the right to share your Personal Data with the entities listed above under the following circumstances:\n'),
        subHeader('As mandated by Philippine law;'),
        sb10(),
        subHeader(
            'In the event of legal actions or in preparation for possible legal proceedings;'),
        sb10(),
        subHeader(
            'For the protection, assertion, or defense of legal rights belonging to ERA Philippines;'),
        sb10(),
        subHeader(
            'With third-party organizations that supply services to us or act on our behalf;'),
        sb10(),
        subHeader('Upon receiving your explicit consent; or'),
        sb10(),
        subHeader('As part of efforts related to disaster recovery planning.'),
        sb40(),
        title(text: '5. Safeguarding Personal Data'),
        sb10(),
        paragraph(
            '5.1 ERA Philippines employs reasonable measures to maintain the confidentiality and security of your Personal Data.  We will not knowingly grant access to this data to any external parties apart from yourself or as outlined in this Policy. However, we cannot guarantee the security of any information transmitted to us, and you do so entirely at your own risk. Specifically, ERA Philippines does not warrant that such information may remain inaccessible, unaltered, uncollected, uncopyable, undeleted, undisclosed, or unmodified in the event of a breach of any of ERA Philippines\' physical, technical, or managerial safeguards.'),
        sb40(),
        title(text: '6. Handling and Retention of Personal Data'),
        sb10(),
        paragraph(
            '6.1 ERA Philippines is dedicated to removing or making your Personal Data unidentifiable once it no longer serves any legitimate business or legal purpose. This will be implemented across all our data storage platforms, whether digital or physical, following our company protocols and applicable agreements.\n'),
        sb10(),
        paragraph(
            '6.2 In instances where our treatment of Personal Data extends beyond the practices described in 6.1, such exceptions will be explicitly defined in the specific contracts relevant to the goods and/or services provided. In these circumstances, the provisions contained within those contracts will take precedence over the general conditions outlined in this Privacy Policy.'),
        sb40(),
        title(text: '7. Policy Updates'),
        sb10(),
        paragraph(
            '7.1 ERA Philippines reserves the right to amend any section of this document as necessary to comply with local legislation, international standards, or for any other justified reason determined by us. We recommend regularly reviewing these terms for any changes. If you do not agree with the updated terms, you are encouraged to contact us immediately with the specific aspects you do not accept. In the event of any discrepancy between these terms and other specific terms, the latter shall prevail to the degree of the conflict.'),
        sb40(),
        title(text: '8. General Provisions'),
        sb10(),
        paragraph(
            '8.1 This Privacy Policy exclusively governs the collection and use of Personal Data by ERA Philippines and does not cover third-party websites that may be linked to our website, even those displaying our branding alongside theirs. ERA Philippines does not share your Personal Data with these third-party platforms. We are not accountable for the privacy policies or practices of these third-party websites; therefore, we advise you to read their privacy policies before submitting any Personal Data.\n'),
        sb10(),
        paragraph(
            '8.2 ERA Philippines commits to not selling your personal information to any third party without your clear approval. Nonetheless, we are not liable for the actions or behaviors of third-party sites that you may access through links or directions from the ERA Philippines website.\n\n'),
        sb30(),
      ],
    );
  }

  // What We Do Section
  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildServiceTile(
          'Real Estate Brokerage Services',
          'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the processionals are committed to guiding you through every step of the process.',
        ),
        sb40(),
        _buildServiceTile(
          'Agent & Broker Training',
          'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.',
        ),
        sb40(),
        _buildServiceTile(
          'Franchise Arrangements',
          'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.',
        ),
        sb40(),
        _buildServiceTile(
          'Property Valuation',
          'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.',
        ),
        sb40(),
        _buildServiceTile('Other Services:',
            '• Legal\n• Taxation\n• Accounting\n• Marketing\n• Branding'),
      ],
    );
  }

  Widget _buildServiceTile(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: title,
            fontSize: EraTheme.h2,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          sb10(),
          EraText(
            text: description,
            fontSize: EraTheme.bodyText,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}

Widget title({text}) {
  return EraText(
    textAlign: TextAlign.start,
    text: text,
    fontSize: EraTheme.paragraphWeb - 2.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    maxLines: 50,
  );
}

Widget paragraph(text) {
  return EraText(
    textAlign: TextAlign.start,
    text: text,
    fontSize: EraTheme.paragraphWeb - 4.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    maxLines: 50,
  );
}

Widget subHeader(subHeader) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth - 10.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: '-    ',
              fontSize: EraTheme.paragraphWeb - 2.sp,
              color: AppColors.black,
            ),
            Flexible(
              child: EraText(
                text: subHeader,
                fontSize: EraTheme.paragraphWeb - 2.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                maxLines: 50,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
