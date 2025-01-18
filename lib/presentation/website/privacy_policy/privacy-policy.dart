import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/constants/assets.dart';
import '../../../app/constants/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sb50(),
            Center(
              child: Image.asset(
                AppEraAssets.eraPh,
                width: 200.w,
                height: 220.h,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: EraText(
                text: 'Privacy Policy',
                color: Colors.black,
                fontSize: EraTheme.h2,
              ),
            ),
            sb70(),
            title(text: 'PRIVACY COMMITMENT'),
            sb30(),
            subtitle(
                text:
                    'Regarding the handling, storage, and dissemination of Personal Data, ERA Philippines is committed to safeguarding privacy and upholding data security. In alignment with this commitment, our leadership, team, and employees endeavor to protect the confidentiality and integrity of all Personal Information we manage in conformity with the Data Privacy Act of 2012 (Philippines). We strive to ensure all processes involving the acquisition, storage, sharing, and application of Personal Data, whether conducted by ERA Philippines or our approved partners, adhere to our stringent Privacy Policy standards.'),
            sb70(),
            title(text: 'COLLECTION OF PERSONAL INFORMATION'),
            sb30(),
            subtitle(
                text:
                    '2.1 In the course of its regular operations, ERA Philippines may gather Personal Data from you through various channels, including: providing your contact information during attendance at our marketing events; leaving your contact details or expressing interest in viewing a property during visits to our showflats; interacting with our salespersons or agents through telephone calls, letters, in-person meetings, or email correspondences; responding to our marketing materials; enlisting the assistance of our salespersons or agents in property transactions such as sales, purchases, or rentals; receiving referrals from business partners and third parties; and when you submit your Personal Data to us for any other purposes.'),
            sb30(),
            subtitle(
                text:
                    '2.2 ERA Philippines commits to maintaining the highest standards of privacy and data protection. In our dealings, we may collect various types of Personal Information to better serve your needs and comply with applicable laws, including, but not limited to:'),
            sb10(),
            paragraph(
                text:
                    '• Basic Personal Information: Name, Address, Date of Birth, Nationality, Gender, and Marital Status.'),
            paragraph(
                text:
                    '• Contact Information: Phone numbers, email addresses, and mailing addresses.'),
            sb10(),
            paragraph(
                text:
                    '• Financial Information: Bank account details, income levels, credit history, and financial statements, essential for facilitating transactions and assessing eligibility for financing.'),
            sb10(),
            paragraph(
                text:
                    '• Property Preferences: Information regarding your preferences for residential or commercial properties, investment interests, and other details pertinent to your real estate inquiries.'),
            sb10(),
            paragraph(
                text:
                    '• Identification Documents: Copies of government-issued identification (e.g., Passport, Driver’s License, SSS ID), required for verification purposes and to ensure compliance with the Anti-Money Laundering Act (AMLA).'),
            sb10(),
            paragraph(
                text:
                    '• Online Activity Data: Website usage, preferences, and interactions captured through cookies and similar technologies to enhance your online experience and provide personalized services.'),
            sb70(),
            title(text: 'OBJECTIVES FOR GATHERING PERSONAL INFORMATION'),
            sb30(),
            subtitle(
                text:
                    '3.1 The Personal Data mentioned in Paragraph 2.2 above is collected for the purposes of:'),
            sb10(),
            paragraph(
                text:
                    '•  Serving as your accredited real estate representative for transactions involving buying, selling, or leasing properties.'),
            sb10(),
            paragraph(
                text:
                    '•  Keeping clients informed about upcoming real estate projects, as well as other property opportunities that might meet their preferences, or existing properties up for sale or lease.'),
            sb10(),
            paragraph(
                text:
                    '•  Engaging with clients who have shown an interest in acquiring or leasing properties.'),
            sb10(),
            paragraph(
                text:
                    '•  Facilitating client reservations for units in new property launches.'),
            sb10(),
            paragraph(
                text:
                    '•  Evaluating property worth utilizing de-identified data.'),
            sb10(),
            paragraph(
                text:
                    '•  Undertaking market studies and analyses with de-identified data.'),
            sb10(),
            paragraph(text: '•  Producing billing statements.'),
            sb10(),
            paragraph(text: '•  Complying with legal mandates.'),
            sb30(),
            subtitle(
                text:
                    '3.2 Furthermore, ERA Philippines undertakes the collection of your Personal Information when you submit an application for either employment or for becoming a real estate salesperson or agent for reasons such as:'),
            sb10(),
            paragraph(
                text:
                    '•  Processing your application, which involves performing preliminary checks concerning your qualifications and professional history.'),
            sb10(),
            paragraph(
                text:
                    '•  Securing or providing references for employment and executing background checks or due diligence processes.'),
            sb10(),
            paragraph(
                text:
                    '•  Compiling information to evaluate your aptness for the position applied.'),
            sb10(),
            paragraph(
                text:
                    '•  Communicating with you as deemed necessary in accordance with the policies and protocols of ERA Philippines, including those relevant to operational continuity.'),
            sb10(),
            paragraph(
                text:
                    '•  Any related purposes connected to the above-mentioned activities.'),
            sb70(),
            title(text: 'DISCLOSURE OF PERSONAL DATA'),
            sb30(),
            subtitle(
                text:
                    '4.1 In accordance with the principles set forth and without limiting the scope of previously mentioned points, your Personal Data may be shared with the following entities:'),
            sb15(),
            paragraph(text: '– Business partners'),
            sb15(),
            paragraph(text: '– Property developers'),
            sb15(),
            paragraph(text: '– Associated brokers'),
            sb15(),
            paragraph(
                text: '– Insurance providers (pertaining to group policies)'),
            sb15(),
            paragraph(text: '– Law enforcement bodies'),
            sb15(),
            paragraph(text: '– Government entities'),
            sb15(),
            paragraph(text: '– Regulatory organizations'),
            sb15(),
            paragraph(text: '– Legal counsel'),
            sb15(),
            paragraph(text: '– Auditing services'),
            sb15(),
            paragraph(text: '– External consultants and service providers'),
            sb15(),
            paragraph(
                text:
                    '– Any real estate agent or salesperson operating under the banner of ERA Philippines to deliver the services offered by ERA Philippines.'),
            sb30(),
            subtitle(
                text:
                    '4.2 ERA Philippines reserves the right to share your Personal Data with the entities listed above under the following circumstances:'),
            sb15(),
            paragraph(text: '– As mandated by Philippine law;'),
            sb15(),
            paragraph(
                text:
                    '– In the event of legal actions or in preparation for possible legal proceedings;'),
            sb30(),
            paragraph(
                text:
                    '– For the protection, assertion, or defense of legal rights belonging to ERA Philippines;'),
            sb15(),
            paragraph(
                text:
                    '– With third-party organizations that supply services to us or act on our behalf;'),
            sb15(),
            paragraph(text: '– Upon receiving your explicit consent; or'),
            sb15(),
            paragraph(
                text:
                    '– As part of efforts related to disaster recovery planning.'),
            sb70(),
            title(text: 'SAFEGUARDING PERSONAL DATA'),
            sb30(),
            subtitle(
                text:
                    '5.1 ERA Philippines employs reasonable measures to maintain the confidentiality and security of your Personal Data.  We will not knowingly grant access to this data to any external parties apart from yourself or as outlined in this Policy. However, we cannot guarantee the security of any information transmitted to us, and you do so entirely at your own risk. Specifically, ERA Philippines does not warrant that such information may remain inaccessible, unaltered, uncollected, uncopyable, undeleted, undisclosed, or unmodified in the event of a breach of any of ERA Philippines’ physical, technical, or managerial safeguards.'),
            sb70(),
            title(text: 'HANDLING AND RETENTION OF PERSONAL DATA'),
            sb30(),
            subtitle(
                text:
                    '6.1 ERA Philippines is dedicated to removing or making your Personal Data unidentifiable once it no longer serves any legitimate business or legal purpose. This will be implemented across all our data storage platforms, whether digital or physical, following our company protocols and applicable agreements.'),
            sb30(),
            subtitle(
                text:
                    '6.2 In instances where our treatment of Personal Data extends beyond the practices described in 6.1, such exceptions will be explicitly defined in the specific contracts relevant to the goods and/or services provided. In these circumstances, the provisions contained within those contracts will take precedence over the general conditions outlined in this Privacy Policy.'),
            sb70(),
            title(text: 'POLICY UPDATES'),
            sb30(),
            subtitle(
                text:
                    '7.1 ERA Philippines reserves the right to amend any section of this document as necessary to comply with local legislation, international standards, or for any other justified reason determined by us. We recommend regularly reviewing these terms for any changes. If you do not agree with the updated terms, you are encouraged to contact us immediately with the specific aspects you do not accept. In the event of any discrepancy between these terms and other specific terms, the latter shall prevail to the degree of the conflict.'),
            sb70(),
            title(text: 'GENERAL PROVISIONS'),
            sb30(),
            subtitle(
                text:
                    '8.1 This Privacy Policy exclusively governs the collection and use of Personal Data by ERA Philippines and does not cover third-party websites that may be linked to our website, even those displaying our branding alongside theirs. ERA Philippines does not share your Personal Data with these third-party platforms. We are not accountable for the privacy policies or practices of these third-party websites; therefore, we advise you to read their privacy policies before submitting any Personal Data.'),
            sb30(),
            subtitle(
                text:
                    '8.2 ERA Philippines commits to not selling your personal information to any third party without your clear approval. Nonetheless, we are not liable for the actions or behaviors of third-party sites that you may access through links or directions from the ERA Philippines website.'),
            sb100(),
          ],
        ),
      ),
    );
  }

  Widget title({text}) {
    return EraText(
      text: text,
      color: AppColors.black.withOpacity(0.7),
      fontSize: EraTheme.h3,
      fontWeight: FontWeight.bold,
      maxLines: 50,
    );
  }

  Widget subtitle({text}) {
    return EraText(
      text: text,
      color: Colors.grey,
      fontSize: EraTheme.h5,
      maxLines: 50,
    );
  }

  Widget paragraph({text}) {
    return EraText(
      text: text,
      color: Colors.grey,
      fontSize: EraTheme.h6,
      maxLines: 50,
    );
  }
}
