import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';

class LocalNotificationsService {
  static LocalNotificationsService get instance => _instance;
  static LocalNotificationsService _instance = LocalNotificationsService();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialization() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_notification');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {}

  Future<void> onDidReceiveLocalNotification(int id, String? title,
      String? body, String? payload) async {
    OpenFilex.open(payload);
  }

  Future<void> showNotification(int id, String? title, String? body,
      String? payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('2309', 'Canal Aplicativo Assinador Invia',
        channelDescription:
        'Canal destinado para notificações do aplicativo INVIA ASSINADOR',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: payload);
  }
}
