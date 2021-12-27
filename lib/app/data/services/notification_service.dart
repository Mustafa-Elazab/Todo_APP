import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app/app/data/models/task.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/ui/pages/notification_page.dart';

class NotificationService extends ChangeNotifier {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    _configureLocalTimeZone();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_flutternotification');

    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
        if(details!=null&&details.didNotificationLaunchApp){
          
        }
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future instantNotification() async {
    await flutterLocalNotificationsPlugin.show(
      1,
      'Theme Services',
      'Theme have been change sucessfully',
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_flutternotification'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<void> showNotification(int hour, int minute, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _coverTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'main_channel', 'Main Channel', 'Main channel notifications',
              importance: Importance.max,
              priority: Priority.max,
              icon: '@drawable/ic_flutternotification'),
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidAllowWhileIdle: true,
        payload: "${task.title}|" + "${task.note}|");
  }

  tz.TZDateTime _coverTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime sheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour - 2, minute);
    if (sheduledDate.isBefore(now)) {
      sheduledDate = sheduledDate.add(const Duration(days: 1));
    }
    return sheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    var timeZone = await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      
    } else {
     
    }
    Get.to(() => NotificationPage(
          label: payload!,
        ));
  }
}
