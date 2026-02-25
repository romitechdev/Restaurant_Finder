import 'package:flutter/material.dart';
import 'package:myapp/providers/reminder_provider.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer2<ThemeProvider, ReminderProvider>(
        builder: (context, themeProvider, reminderProvider, child) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('Dark Theme'),
                subtitle: const Text('Aktifkan tema gelap'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.setDarkMode(value);
                },
              ),
              SwitchListTile(
                title: const Text('Daily Reminder'),
                subtitle: const Text('Notifikasi setiap hari pukul 11.00 AM'),
                value: reminderProvider.isDailyReminderEnabled,
                onChanged: (value) {
                  reminderProvider.setDailyReminder(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
