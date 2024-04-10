import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();



  static void initialize() {
    // Initialization  setting for android
    const InitializationSettings initializationSettingsAndroid =
    InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }




}