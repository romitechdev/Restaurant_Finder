import 'package:flutter/material.dart';
import 'package:myapp/data/local/database_helper.dart';
import 'package:myapp/models/restaurant.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider(this._databaseHelper) {
    loadFavorites();
  }

  final DatabaseHelper _databaseHelper;

  List<Restaurant> _favorites = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Restaurant> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

  Future<void> loadFavorites() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _favorites = await _databaseHelper.getFavorites();
    } catch (_) {
      _errorMessage =
          'Daftar favorit belum bisa dibuka saat ini. Coba beberapa saat lagi.';
      _favorites = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await _databaseHelper.insertFavorite(restaurant);
    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _databaseHelper.deleteFavorite(id);
    await loadFavorites();
  }

  Future<void> toggleFavorite(Restaurant restaurant) async {
    if (isFavorite(restaurant.id)) {
      await removeFavorite(restaurant.id);
    } else {
      await addFavorite(restaurant);
    }
  }
}
