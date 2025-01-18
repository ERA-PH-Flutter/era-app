import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../router/route_string.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb40(),
              EraText(
                text: 'AGREEMENT',
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.hint.withOpacity(0.7),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 8.w, left: 5.w, top: 8.h, bottom: 8.h),
                child: EraText(
                  text: 'Terms of Service',
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
              sb30(),
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
                  'Basic Personal Information: Name, Address, Date of Birth, Nationality, Gender, and Marital Status.\n'),
              subHeader(
                  'Contact Information: Phone numbers, email addresses, and mailing addresses.\n'),
              subHeader(
                  'Financial Information: Bank account details, income levels, credit history, and financial statements, essential for facilitating transactions and assessing eligibility for financing.\n'),
              subHeader(
                  'Property Preferences: Information regarding your preferences for residential or commercial properties, investment interests, and other details pertinent to your real estate inquiries.\n'),
              subHeader(
                  'Identification Documents: Copies of government-issued identification (e.g., Passport, Driver’s License, SSS ID), required for verification purposes and to ensure compliance with the Anti-Money Laundering Act (AMLA).\n'),
              subHeader(
                  'Online Activity Data: Website usage, preferences, and interactions captured through cookies and similar technologies to enhance your online experience and provide personalized services.\n'),
              sb10(),
              paragraph(
                  '2.3 Consent for Third-party Personal Information.\nWhen you provide us with Personal Information of third parties (e.g., co-buyers, dependents), it is your responsibility to ensure that they are aware of this fact and have consented to their data being shared with us for the purposes outlined.\n'),
              sb10(),
              paragraph(
                  '2.4 Your Rights and Consent In line with the Data Privacy Act of 2012, we emphasize your rights over your Personal Information, including the right to access, correct, and object to the processing of your data. We are committed to obtaining your explicit consent before collecting any Personal Information, with a clear explanation of its intended use and safeguarding measures.'),
              sb10(),
              paragraph(
                  '\nBy engaging with ERA Philippines, you acknowledge your consent to this policy. Should you wish to modify your consent or inquire about your Personal Information, our dedicated privacy team is at your disposal to assist with any requests.'),
              sb40(),
              title(text: '3. Objectives for Gathering Personal Information'),
              sb10(),
              paragraph(
                  '3.1 The Personal Data mentioned in Paragraph 2.2 above is collected for the purposes of:\n'),
              subHeader(
                  'Serving as your accredited real estate representative for transactions involving buying, selling, or leasing properties.\n'),
              subHeader(
                  'Keeping clients informed about upcoming real estate projects, as well as other property opportunities that might meet their preferences, or existing properties up for sale or lease.\n'),
              subHeader(
                  'Engaging with clients who have shown an interest in acquiring or leasing properties.\n'),
              subHeader(
                  'Facilitating client reservations for units in new property launches.\n'),
              subHeader(
                  'Evaluating property worth utilizing de-identified data.\n'),
              subHeader(
                  'Undertaking market studies and analyses with de-identified data.\n'),
              subHeader('Producing billing statements.\n'),
              subHeader('Complying with legal mandates.\n'),
              sb10(),
              paragraph(
                  '3.2 Furthermore, ERA Philippines undertakes the collection of your Personal Information when you submit an application for either employment or for becoming a real estate salesperson or agent for reasons such as:\n'),
              subHeader(
                  'Processing your application, which involves performing preliminary checks concerning your qualifications and professional history.\n'),
              subHeader(
                  'Securing or providing references for employment and executing background checks or due diligence processes.\n'),
              subHeader(
                  'Compiling information to evaluate your aptness for the position applied.\n'),
              subHeader(
                  'Communicating with you as deemed necessary in accordance with the policies and protocols of ERA Philippines, including those relevant to operational continuity.\n'),
              subHeader(
                  'Any related purposes connected to the above-mentioned activities.\n'),
              sb40(),
              title(text: '4. Disclosure of Personal Data'),
              sb10(),
              paragraph(
                  '4.1 In accordance with the principles set forth and without limiting the scope of previously mentioned points, your Personal Data may be shared with the following entities:\n'),
              subHeader('Business partners\n'),
              subHeader('Property developers\n'),
              subHeader('Associated brokers\n'),
              subHeader('Insurance providers (pertaining to group policies\n'),
              subHeader('Law enforcement bodies\n'),
              subHeader('Government entities\n'),
              subHeader('Regulatory organizations\n'),
              subHeader('Legal counsel\n'),
              subHeader('Auditing services\n'),
              subHeader('External consultants and service providers\n'),
              subHeader(
                  'Any real estate agent or salesperson operating under the banner of ERA Philippines to deliver the services offered by ERA Philippines.\n'),
              sb10(),
              paragraph(
                  '4.2 ERA Philippines reserves the right to share your Personal Data with the entities listed above under the following circumstances:\n'),
              subHeader('As mandated by Philippine law;\n'),
              subHeader(
                  'In the event of legal actions or in preparation for possible legal proceedings;\n'),
              subHeader(
                  'For the protection, assertion, or defense of legal rights belonging to ERA Philippines;\n'),
              subHeader(
                  'With third-party organizations that supply services to us or act on our behalf;\n'),
              subHeader('Upon receiving your explicit consent; or\n'),
              subHeader(
                  'As part of efforts related to disaster recovery planning.\n'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    text: 'Accept',
                    color: AppColors.blue,
                    width: 150.w,
                    onTap: () {
                      Get.toNamed(RouteString.createaccount);
                    },
                    bgColor: AppColors.white,
                    // borderSide: BorderSide(color: AppColors.blue),
                    border: Border.all(color: AppColors.blue),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  Button(
                    text: 'Decline',
                    width: 150.w,
                    onTap: () {},
                    bgColor: AppColors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ],
              ),
              sb30(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget title({text}) {
    return EraText(
      text: text,
      fontSize: EraTheme.header - 4.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      maxLines: 50,
    );
  }

  Widget paragraph(paragraph) {
    return EraText(
      text: paragraph,
      fontSize: EraTheme.paragraph - 2.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
      maxLines: 50,
    );
  }

  Widget subHeader(subHeader) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth - 10.sp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: '-    ',
                fontSize: EraTheme.paragraph - 2.sp,
                color: AppColors.black,
              ),
              Flexible(
                child: EraText(
                  text: subHeader,
                  fontSize: EraTheme.paragraph - 2.sp,
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
}
