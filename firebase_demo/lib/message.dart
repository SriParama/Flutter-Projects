import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notifications_firebase_flutter/push_notifications.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Map payload = {};
  String title = '';
  String body = '';
  String sendTime = '';
  bool isload = true;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  List messages = [];
  bool isLoaded = true;
  // final firebaseStorage = FirebaseFirestore.instance;
  getDetails() async {
    try {
      var details = await PushNotifications.firestore
          .collection('global_Messages')
          .doc('Notifications')
          .get();
      if (details['message'] != null) {
        messages = details['message'];
        isLoaded = false;
      } else {
        messages = [];
      }
    } catch (e) {
      // print(e);
      messages = [];
    }

    print('*****************');
    print(messages);
    // print(details.docs[0].data()['List']);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      print('++++++RemoteMessage');
      payload = data.data;
      title = data.notification!.title!;
      body = data.notification!.body!;
      sendTime = data.sentTime.toString();
    }
    if (data is NotificationResponse) {
      print('++++++NotificationResponse');
      // payload = jsonDecode(data!.pa);
      // payload = payload;
      payload = jsonDecode(data.payload!);
      title = payload['title'];
      body = payload['body'];
      sendTime = payload['sendTime'];

      // body = data.notificationResponseType.name;
      // sendTime = data.actionId!;

      // title =jsonDecode(data.payload.);
      // body = data.notification!.body!;
    }

    return Scaffold(
        appBar: AppBar(title: Text("Your Message")),
        body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(messages[index]['title']),
              subtitle: Text(messages[index]['body']),
            );
          },
        )
        // Column(
        //   children: [
        //     Text(payload.toString()),
        //     Text(title),
        //     Text(body),
        //     Text(sendTime),
        //   ],
        // ),
        );
  }
}
