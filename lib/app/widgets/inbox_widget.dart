import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../presentation/global.dart';
import 'custom_appbar.dart';

class InboxWidget extends StatelessWidget {
  const InboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          final data = snapshot.data?.docs;
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              final message = Message.fromJson(data![index]);
              if(data[index]['to'] == "all" || data[index]['to'] == user!.id){
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
              }
              return Container();
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class Message {
  final String title;
  final String subject;
  final String time;

  Message({
    required this.title,
    required this.subject,
    required this.time,
  });

  factory Message.fromJson(json){
    return Message(title: json["title"], subject: json['subject'], time: DateFormat.jm().format(DateTime.parse(json['date'].toDate().toString())));
  }
}

class InboxScreen extends StatelessWidget {

  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: InboxWidget(),
    );
  }
}
