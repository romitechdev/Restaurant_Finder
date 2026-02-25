import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:myapp/models/restaurant.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static const String _databaseName = 'restaurant_finder.db';
  static const int _databaseVersion = 1;
  static const String favoriteTable = 'favorites';

  static final List<Restaurant> _webFavorites = [];

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $favoriteTable (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            pictureId TEXT NOT NULL,
            city TEXT NOT NULL,
            rating REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    if (kIsWeb) {
      _webFavorites.removeWhere((item) => item.id == restaurant.id);
      _webFavorites.add(restaurant);
      return;
    }

    final db = await database;
    await db.insert(favoriteTable, {
      'id': restaurant.id,
      'name': restaurant.name,
      'description': restaurant.description,
      'pictureId': restaurant.pictureId,
      'city': restaurant.city,
      'rating': restaurant.rating,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteFavorite(String id) async {
    if (kIsWeb) {
      _webFavorites.removeWhere((item) => item.id == id);
      return;
    }

    final db = await database;
    await db.delete(favoriteTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Restaurant>> getFavorites() async {
    if (kIsWeb) {
      return List<Restaurant>.from(_webFavorites);
    }

    final db = await database;
    final result = await db.query(favoriteTable);

    return result
        .map(
          (row) => Restaurant(
            id: row['id'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            pictureId: row['pictureId'] as String,
            city: row['city'] as String,
            rating: (row['rating'] as num).toDouble(),
          ),
        )
        .toList();
  }

  Future<bool> isFavorite(String id) async {
    if (kIsWeb) {
      return _webFavorites.any((item) => item.id == id);
    }

    final db = await database;
    final result = await db.query(
      favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
