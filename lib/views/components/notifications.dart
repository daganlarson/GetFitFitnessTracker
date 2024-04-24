import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class Notifications{

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async{
    // Initialization  setting for android
    _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    const InitializationSettings initializationSettingsAndroid =
    InitializationSettings(
        android: AndroidInitializationSettings('ic_launcher'));
    await _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) => null,
    );
  }

  static void scheduleEvent({required String title, required String message, required int length}) async{
    tz.initializeTimeZones();
    await _notificationsPlugin.zonedSchedule(
        0,
        title,
        message,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: length)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'EventID', 'EventNotifChannel',
                channelDescription: 'The one where the events go')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future sendNotification({required String title, required String message} ) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('EventID', 'EventNotifChannel',
        channelDescription: 'The one where the events go',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _notificationsPlugin.show(
        0, title, message, notificationDetails);
  }

}