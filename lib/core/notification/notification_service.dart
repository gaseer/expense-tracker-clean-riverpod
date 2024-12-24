import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const DarwinInitializationSettings iOSInitSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Future<void> scheduleWeeklyNotifications(List<String> messages) async {
  //   for (int i = 0; i < messages.length; i++) {
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       i, // Unique ID
  //       'Daily Reminder',
  //       messages[i],
  //       tz.TZDateTime.now(tz.local).add(Duration(days: i, hours: 9)), // 9 AM
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'daily_reminder_channel',
  //           'Daily Reminders',
  //           channelDescription: 'Reminders to log daily expenses',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //         ),
  //       ),
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     );
  //   }
  // }

  Future<void> scheduleMinuteNotifications() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'minute_reminder_channel',
      'Minute Reminders',
      channelDescription: 'Reminders triggered every minute',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);
    final Random random = Random();
    for (int i = 0; i < 7; i++) {
      int randomIndex = random.nextInt(dailyMessages.length);
      await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Reminder',
        dailyMessages[randomIndex],
        RepeatInterval.everyMinute,
        notificationDetails,
        // androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );
    }
  }
}

List<String> dailyMessages = [
  "Start your week strong! 💪 Log today's expenses and own your finances.",
  "Tuesday tip: Small savings today lead to big rewards tomorrow! 💰",
  "Midweek check-in! 🗓️ Are you staying on track? Update your expenses now!",
  "Throwback Thursday: How have your expenses improved? 🚀 Let's log today!",
  "Happy Friday! 🎉 Celebrate by keeping your budget in check. Log now!",
  "Saturday vibes: Relax but stay smart! 🛍️ Update your spending.",
  "Sunday prep: A new week is ahead. Reflect and log today's expenses! 🌟",
];
