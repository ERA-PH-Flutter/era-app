import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InboxWidget extends StatelessWidget {
  final List<Message> messages;

  InboxWidget({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Icon(
                  CupertinoIcons.mail,
                  color: AppColors.kRedColor,
                ),
              ),
              title: EraText(
                text: message.title,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              subtitle: EraText(
                text: message.subject,
                color: AppColors.black,
              ),
              trailing: EraText(
                text: message.time,
                color: AppColors.hint,
              ),
              onTap: () {
                Get.to(MessageScreen(message: message));
              },
            ),
            Divider(), // Add a Divider here
          ],
        );
      },
    );
  }
}

//IM not sure where to put the from?
class Message {
  final String title;
  // final String from;
  final String subject;
  final String time;

  Message({
    required this.title,
    //  required this.from,
    required this.subject,
    required this.time,
  });
}

class InboxScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(
        title: 'NEWS FROM ERA PH',
        //   from: 'ADMIN',
        subject:
            'It is a ssong established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        time: '10:30 AM'),
    Message(
        title: 'NEWS FROM ERA PH',

        //   from: 'ADMIN',
        subject:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        time: '10:30 AM'),
    Message(
        title: 'NEWS FROM ERA PH',

        //   from: 'ADMIN',
        subject:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
        time: '10:30 AM'),
    Message(
        title: 'NEWS FROM ERA PH',

        //    from: 'ADMIN',
        subject:
            'It is a long establishedss fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layoutsss.',
        time: '10:30 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: InboxWidget(messages: messages),
    );
  }
}
