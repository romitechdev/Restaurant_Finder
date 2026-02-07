// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/api_response.dart';
import 'package:myapp/providers/restaurant_provider.dart';
import 'package:myapp/providers/theme_provider.dart';
import 'package:myapp/widgets/loading_indicator.dart';
import 'package:myapp/widgets/error_widget.dart';
import 'package:myapp/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<RestaurantProvider>(context, listen: false)
            .fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.auto_mode),
            onPressed: () => themeProvider.setSystemTheme(),
            tooltip: 'Set System Theme',
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          final response = provider.restaurantList;
          return switch (response) {
            ApiLoading() => const LoadingIndicator(),
            ApiSuccess(data: final restaurants) => ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(restaurant: restaurants[index]);
                },
              ),
            ApiError(message: final message) =>
              ErrorMessageWidget(message: message),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}