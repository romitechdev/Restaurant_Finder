import 'package:flutter/material.dart';
import 'package:myapp/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderProvider extends ChangeNotifier {
  ReminderProvider(this._preferences, this._notificationService) {
    _isDailyReminderEnabled = _preferences.getBool(_reminderKey) ?? false;
    if (_isDailyReminderEnabled) {
      _notificationService.scheduleDailyReminder();
    }
  }

  static const _reminderKey = 'daily_reminder_enabled';

  final SharedPreferences _preferences;
  final NotificationService _notificationService;

  bool _isDailyReminderEnabled = false;

  bool get isDailyReminderEnabled => _isDailyReminderEnabled;

  Future<void> setDailyReminder(bool isEnabled) async {
    _isDailyReminderEnabled = isEnabled;
    notifyListeners();

    await _preferences.setBool(_reminderKey, isEnabled);

    if (isEnabled) {
      await _notificationService.scheduleDailyReminder();
    } else {
      await _notificationService.cancelDailyReminder();
    }
  }
}
