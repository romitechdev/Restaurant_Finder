// lib/providers/restaurant_provider.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/api_response.dart';
import 'package:myapp/models/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantProvider({http.Client? client})
    : _client = client ?? http.Client(),
      _ownsClient = client == null;

  final http.Client _client;
  final bool _ownsClient;
  static const Duration _requestTimeout = Duration(seconds: 15);

  ApiResponse<List<Restaurant>> _restaurantList = const ApiLoading();
  ApiResponse<RestaurantDetail> _restaurantDetail = const ApiLoading();

  ApiResponse<List<Restaurant>> get restaurantList => _restaurantList;
  ApiResponse<RestaurantDetail> get restaurantDetail => _restaurantDetail;

  Future<void> fetchRestaurantList() async {
    try {
      _restaurantList = const ApiLoading();
      notifyListeners();
      final response = await _client
          .get(Uri.parse('https://restaurant-api.dicoding.dev/list'))
          .timeout(_requestTimeout);
      if (response.statusCode == 200) {
        final data = restaurantResponseFromJson(response.body);
        _restaurantList = ApiSuccess(data.restaurants);
      } else {
        _restaurantList = const ApiError('Gagal memuat daftar restoran');
      }
    } on TimeoutException {
      _restaurantList = const ApiError(
        'Koneksi terlalu lama. Periksa internet Anda lalu coba lagi.',
      );
    } on Exception {
      _restaurantList = const ApiError(
        'Tidak dapat memuat daftar restoran. Periksa koneksi internet Anda.',
      );
    } catch (e) {
      _restaurantList = const ApiError('Terjadi kesalahan saat memuat data');
    }
    notifyListeners();
  }

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _restaurantDetail = const ApiLoading();
      notifyListeners();
      final response = await _client
          .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'))
          .timeout(_requestTimeout);
      if (response.statusCode == 200) {
        final data = detailRestaurantResponseFromJson(response.body);
        _restaurantDetail = ApiSuccess(data.restaurant);
      } else {
        _restaurantDetail = const ApiError('Gagal memuat detail restoran');
      }
    } on TimeoutException {
      _restaurantDetail = const ApiError(
        'Koneksi terlalu lama. Periksa internet Anda lalu coba lagi.',
      );
    } on Exception {
      _restaurantDetail = const ApiError(
        'Tidak dapat memuat detail restoran. Periksa koneksi internet Anda.',
      );
    } catch (e) {
      _restaurantDetail = const ApiError(
        'Terjadi kesalahan saat memuat detail',
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    if (_ownsClient) {
      _client.close();
    }
    super.dispose();
  }
}
