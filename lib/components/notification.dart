import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:safe_droid/components/constantes.dart';
import 'package:safe_droid/screens/home.dart';
import 'package:safe_droid/screens/param.dart';

import '../main.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: "high_importance_channel",
            channelKey: "high_importance_channel",
            channelName: "Basic Notifications",
            channelDescription: "Notification AndroSafe",
            defaultColor: cBleuFonce,
            ledColor: cBlanc,
            importance: NotificationImportance.High,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
            criticalAlerts: true,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: "high_importance_channel_group",
            channelGroupName: "Groupe 1",
          )
        ],
        debug: true);

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreated,
      onNotificationDisplayedMethod: onNotificationDisplayed,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  static Future<void> onNotificationCreated(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreated');
  }

  static Future<void> onNotificationDisplayed(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayed');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    final payload = receivedAction.payload ?? {};
    if (payload['navigate'] == 'true') {
      Home.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => const Menu()));
      MainApp.navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (_) => const Menu(),
      ));
      debugPrint('Ouvrir Page');
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDimissActionReceivedMethod');
  }

  static Future<void> showNotification({
    required String titre,
    required String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "high_importance_channel",
        title: titre,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null,
    );
  }
}
