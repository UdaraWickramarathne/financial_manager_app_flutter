import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    // Handle different actions based on the actionId
    if (notificationResponse.actionId == 'complete_action') {
      // Logic for handling "Complete" action
      print("Notification marked as complete.");
      await flutterLocalNotificationsPlugin.cancel(notificationResponse.id!);
    } else if (notificationResponse.actionId == 'snooze_action') {
      // Logic for handling "Snooze" action
      print("Notification snoozed.");
      await snoozeNotification(notificationResponse.id!);
    } else {
      print("Notification received.");
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'instant_notification_channel_id',
        'Instant Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        actions: [
          AndroidNotificationAction('complete_action', 'Complete'),
          AndroidNotificationAction('snooze_action', 'Snooze'),
        ],
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true, // Play the default iOS notification sound
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  static Future<void> scheduleNotification(int id, String title, String body,
      DateTime scheduledTime, String frequency) async {
    // Define notification details
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminder Channel',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        actions: [
          AndroidNotificationAction('complete_action', 'Complete'),
          AndroidNotificationAction('snooze_action', 'Snooze'),
        ],
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
      ),
    );

    // Use `periodicallyShow` for repeat frequencies
    if (frequency == 'Every minute') {
      await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.everyMinute,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } else if (frequency == 'Everyday') {
      await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.daily,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } else if (frequency == 'Every week') {
      await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.weekly,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } else {
      // For custom intervals like monthly or one-time notifications, use `zonedSchedule`
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }

  static Future<void> snoozeNotification(int id) async {
    // Snooze logic (e.g., 5 minutes from now)
    final snoozeTime =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));
    await scheduleNotification(
        id, 'Reminder', 'Snoozed notification', snoozeTime, 'never');
  }

  static void cancelReminderNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
