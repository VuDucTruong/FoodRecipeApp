import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_recipe_app/app/app_prefs.dart';
import 'package:food_recipe_app/app/constant.dart';
import 'package:food_recipe_app/data/mapper/mapper.dart';
import 'package:food_recipe_app/data/responses/notification_response.dart';
import 'package:food_recipe_app/domain/entity/notification_enitty.dart';
import 'package:signalr_netcore/signalr_client.dart';

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late NotificationDetails platformChannelSpecifics;
  late final HubConnection hubConnection;
  final AppPreferences _appPreferences;

  NotificationHelper(this._appPreferences);

  void _initSignalR() {
    hubConnection = HubConnectionBuilder()
        .withUrl(Constant.notificationUrl,
            options: HttpConnectionOptions(
                accessTokenFactory: () async => _appPreferences.getUserToken()))
        .build();
    print(hubConnection.connectionId);
    hubConnection.on("ReceiveNotification", (value) async {
      await showNotification(value);
    });

    hubConnection.start()?.catchError((error) {
      print("Connection failed: $error");
    });
  }

  Future<bool> requestNotificationPermission() async {
    bool isPermitted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
    _appPreferences.setIsNotification(isPermitted);
    return isPermitted;
  }

  Future<void> setUpLocalNotification() async {
    await requestNotificationPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'cookitzzzz',
      'Cook It',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    platformChannelSpecifics =
        const NotificationDetails(android: androidPlatformChannelSpecifics);

    print('set up complete!');
    _initSignalR();
  }

  Future selectNotification(String? payload) async {
    // Handle notification tapped logic here
  }

  Future<void> showNotification(List<Object?>? objectList) async {
    if (!_appPreferences.getIsNotification()) return;
    List<NotificationEntity> notificationList = [];
    if (objectList != null) {
      for (var element in objectList) {
        if (element != null) {
          NotificationEntity entity =
              AppNotificationResponse.fromJson(element as Map<String, dynamic>)
                  .toEntity();
          notificationList.add(entity);
        }
      }
    }
    for (int i = 0; i < notificationList.length; i++) {
      await flutterLocalNotificationsPlugin.show(
        i,
        notificationList[i].title,
        notificationList[i].content,
        platformChannelSpecifics,
      );
    }
  }
}
