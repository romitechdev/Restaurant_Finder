// lib/models/restaurant.dart

import 'dart:convert';

RestaurantResponse restaurantResponseFromJson(String str) => RestaurantResponse.fromJson(json.decode(str));

DetailRestaurantResponse detailRestaurantResponseFromJson(String str) => DetailRestaurantResponse.fromJson(json.decode(str));

class RestaurantResponse {
    final bool error;
    final String message;
    final int count;
    final List<Restaurant> restaurants;

    RestaurantResponse({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );
}

class DetailRestaurantResponse {
    final bool error;
    final String message;
    final RestaurantDetail restaurant;

    DetailRestaurantResponse({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) => DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
    );
}

class Restaurant {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );
}

class RestaurantDetail {
    final String id;
    final String name;
    final String description;
    final String city;
    final String address;
    final String pictureId;
    final double rating;
    final Menus menus;

    RestaurantDetail({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        required this.rating,
        required this.menus,
    });

    factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
    );
}

class Menus {
    final List<MenuItem> foods;
    final List<MenuItem> drinks;

    Menus({
        required this.foods,
        required this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<MenuItem>.from(json["foods"].map((x) => MenuItem.fromJson(x))),
        drinks: List<MenuItem>.from(json["drinks"].map((x) => MenuItem.fromJson(x))),
    );
}

class MenuItem {
    final String name;

    MenuItem({
        required this.name,
    });

    factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        name: json["name"],
    );
}
