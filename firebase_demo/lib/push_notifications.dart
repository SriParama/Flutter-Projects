import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notifications_firebase_flutter/main.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // request notification permission
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // get the device fcm token
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");
  }

//Subscribe Message
  static Future<void> sendNotificationToTopic({
    required String title,
    required String body,
    required String topic,
  }) async {
    final String serverKey =
        'AAAADqaqgb8:APA91bFPlI4EQmp82JyYcsWEFaXAj2VtmjOddlI4aI6oePFDyowZQ9CIgfMDEKwCRYldpSsITF6UBiDMk0qJDT6xTMb7kCXczJLvKSPsD2wRdf33N---lVxEiIgfyOHPHagxQbIAJKoM';

    String url = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> payload = {
      'notification': {
        'title': title,
        'body': body,
      },
      'priority': 'high',
      'data': {
        "key": DateTime.now().toString(),
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        "message": "Hello FCM!",
      },
      'to': '/topics/$topic', // Send to a specific topic
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    // await PushNotifications.getNotification(
    //     title: title, body: body, messageId: DateTime.now().toString());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(payload),
      );
    } catch (e) {
      print(e);
    }
  }

// initalize local notifications
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!
        .pushNamed("/message", arguments: notificationResponse);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required DateTime sendTime,
    required Map payload,
  }) async {
    Map data = {'title': title, 'body': body, 'sendTime': sendTime.toString()};
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: jsonEncode(data));
  }

  static List notiDetails = [];

  // static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<String> getNotification(
      {required String title, required String body, required String messageId
      // required bool deviceIsActive,
      }) async {
    // getMessageFromFireBase();
    print('getNotification');
    print('before..............');
    print(notiDetails);

    notiDetails = await load();

    print('*****after*********');
    print(notiDetails);
    List msgId = [];
    for (var message in notiDetails) {
      msgId.add(message['id']);
    }
    print('Message Id');
    print(msgId);
    if (!msgId.contains(messageId)) {
      notiDetails.add({"title": title, 'body': body, 'id': messageId});
    }

    //  bool ismsgId =  msg.;

    print('After Adding notification');
    print(notiDetails);
    String res = 'Some Error Occured';
    try {
      await firestore
          .collection('global_Messages')
          .doc('Notifications')
          .update({"message": notiDetails});
      res = 'success';
      print('After Adding from notification');
      print(notiDetails);
      print('res : $res');
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  static Future<List<Map<String, dynamic>>> load() async {
    List<Map<String, dynamic>> msg = [];

    try {
      print('Load 1 ');
      var collectionRef = firestore.collection('global_Messages');
      var collectionSnapshot = await collectionRef.get();

      if (collectionSnapshot.docs.isNotEmpty) {
        print('Document is not Empty');

        var docSnapshot = await collectionRef.doc('Notifications').get();
        if (docSnapshot.exists && docSnapshot.data()!.containsKey('message')) {
          print('Data is Not Empty');
          msg = List<Map<String, dynamic>>.from(docSnapshot.get('message'));
          print(msg);
        } else {
          print('Setting the messages');
          await collectionRef.doc('Notifications').set({'message': []});
        }
      } else {
        print('else Part');
        await collectionRef.doc('Notifications').set({'message': []});
        msg = [];
      }
    } catch (e) {
      print('Error loading data from Firestore: $e');
    }

    return msg;
  }
}
