// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/data/local/database_helper.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/providers/reminder_provider.dart';
import 'package:myapp/providers/restaurant_provider.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    MyApp(preferences: preferences, notificationService: notificationService),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.preferences,
    required this.notificationService,
  });

  final SharedPreferences preferences;
  final NotificationService notificationService;

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.deepPurple;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(preferences)),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(DatabaseHelper.instance),
        ),
        ChangeNotifierProvider(
          create: (_) => ReminderProvider(preferences, notificationService),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Restaurant App',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: primarySeedColor,
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: primarySeedColor,
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
