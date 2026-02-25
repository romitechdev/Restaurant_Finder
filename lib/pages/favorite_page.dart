import 'package:flutter/material.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:myapp/widgets/loading_indicator.dart';
import 'package:myapp/widgets/restaurant_card.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurants')),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingIndicator();
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  provider.errorMessage!,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (provider.favorites.isEmpty) {
            return const Center(child: Text('Belum ada restoran favorit.'));
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurant: provider.favorites[index]);
            },
          );
        },
      ),
    );
  }
}
