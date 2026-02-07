// lib/providers/restaurant_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/api_response.dart';
import 'package:myapp/models/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  ApiResponse<List<Restaurant>> _restaurantList = const ApiLoading();
  ApiResponse<RestaurantDetail> _restaurantDetail = const ApiLoading();

  ApiResponse<List<Restaurant>> get restaurantList => _restaurantList;
  ApiResponse<RestaurantDetail> get restaurantDetail => _restaurantDetail;

  Future<void> fetchRestaurantList() async {
    try {
      _restaurantList = const ApiLoading();
      notifyListeners();
      final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
      if (response.statusCode == 200) {
        final data = restaurantResponseFromJson(response.body);
        _restaurantList = ApiSuccess(data.restaurants);
      } else {
        _restaurantList = const ApiError('Failed to load restaurant list');
      }
    } catch (e) {
      _restaurantList = ApiError(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _restaurantDetail = const ApiLoading();
      notifyListeners();
      final response = await http.get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
      if (response.statusCode == 200) {
        final data = detailRestaurantResponseFromJson(response.body);
        _restaurantDetail = ApiSuccess(data.restaurant);
      } else {
        _restaurantDetail = const ApiError('Failed to load restaurant detail');
      }
    } catch (e) {
      _restaurantDetail = ApiError(e.toString());
    }
    notifyListeners();
  }
}
