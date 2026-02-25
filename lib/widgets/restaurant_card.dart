// lib/widgets/restaurant_card.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/restaurant.dart';
import 'package:myapp/pages/detail_page.dart';
import 'package:myapp/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(restaurantId: restaurant.id),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.location_city, size: 16),
                      const SizedBox(width: 4),
                      Text(restaurant.city),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(restaurant.rating.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, child) {
                    final isFavorite = favoriteProvider.isFavorite(
                      restaurant.id,
                    );
                    return IconButton(
                      onPressed: () {
                        favoriteProvider.toggleFavorite(restaurant);
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
