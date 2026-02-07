// lib/pages/detail_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/api_response.dart';
import 'package:myapp/models/restaurant.dart';
import 'package:myapp/providers/restaurant_provider.dart';
import 'package:myapp/widgets/loading_indicator.dart';
import 'package:myapp/widgets/error_widget.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({super.key, required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurantDetail(widget.restaurantId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restaurant'),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          final response = provider.restaurantDetail;
           return switch (response) {
            ApiLoading() => const LoadingIndicator(),
            ApiSuccess(data: final restaurant) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_city, size: 16),
                            const SizedBox(width: 4),
                            Text(restaurant.city),
                            const SizedBox(width: 16),
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Expanded(child: Text(restaurant.address)),
                          ],
                        ),
                        const SizedBox(height: 8),
                         Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(restaurant.rating.toString()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(restaurant.description),
                        const SizedBox(height: 16),
                        Text(
                          'Foods',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        _buildMenuList(restaurant.menus.foods),
                        const SizedBox(height: 16),
                        Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        _buildMenuList(restaurant.menus.drinks),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ApiError(message: final message) =>
              ErrorMessageWidget(message: message),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildMenuList(List<MenuItem> menus) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(menus[index].name)),
            ),
          );
        },
      ),
    );
  }
}
