import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:future_builder_app/Feature/Aboutus/About_us.dart';
import 'package:future_builder_app/main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Initialize Awesome Notifications first
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        ),
      ],
      debug: true,
    );

    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // ✅ استقبال الإشعار في foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 إشعار والتطبيق مفتوح: ${message.data}");

      // عرض إشعار محلي
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'basic_channel',
          title: message.notification?.title ?? "New Notification",
          body: message.notification?.body ?? "You have a new message",
          notificationLayout: NotificationLayout.Default,
        ),
      );
    });

    // ✅ لما يضغط على الاشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🚀 فتح التطبيق من إشعار");
      _openFixedPage();
    });

    // ✅ لو التطبيق كان مغلق وفتح بسبب الاشعار
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _openFixedPage();
    }
  }

  void _openFixedPage() {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => AboutUsPage()),
    );
  }
}