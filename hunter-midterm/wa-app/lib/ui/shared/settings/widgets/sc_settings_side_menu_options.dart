import 'package:flutter/material.dart';

import '../password_and_security.dart';
import '../account_settings.dart';
import '../notification_settings.dart';
class SharedSettingsOptions {
  static List dashBoardButtons = [

    SettingsMenuItemModel(
        title: 'Account Settings',
        subtitle: 'Personal Informations, Email',
        index: 0,
        iconData: Icons.person,
        loadWidget: const SharedAccountSettings(),
    ),

    SettingsMenuItemModel(
      title: 'Password & Security',
      subtitle: 'Change Password, 2FA',
      index: 1,
      iconData: Icons.lock,
      loadWidget: const PasswordAndSecurity(),
    ),
    SettingsMenuItemModel(
      title: 'Notifications',
      subtitle: 'Change Password, 2FA',
      index: 2,
      iconData: Icons.notifications,
      loadWidget: const ScNotificationsSettings(),
    ),
  ];
}


class SettingsMenuItemModel{

  late IconData iconData;
  late String title;
  late String subtitle;
  late int index;
  late Widget loadWidget;
  SettingsMenuItemModel({required this.subtitle,required this.title,required this.index,required this.iconData,required this.loadWidget});

}
