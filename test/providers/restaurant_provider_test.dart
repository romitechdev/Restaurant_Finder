import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myapp/models/api_response.dart';
import 'package:myapp/models/restaurant.dart';
import 'package:myapp/providers/restaurant_provider.dart';

void main() {
  group('RestaurantProvider fetchRestaurantList', () {
    test('state awal provider terdefinisi sebagai loading', () {
      final provider = RestaurantProvider(
        client: MockClient((_) async => http.Response('{}', 200)),
      );

      expect(provider.restaurantList, isA<ApiLoading<List<Restaurant>>>());
    });

    test('mengembalikan daftar restoran saat API berhasil', () async {
      final mockClient = MockClient((request) async {
        if (request.url.toString() ==
            'https://restaurant-api.dicoding.dev/list') {
          return http.Response(
            '''
            {
              "error": false,
              "message": "success",
              "count": 1,
              "restaurants": [
                {
                  "id": "rqdv5juczeskfw1e867",
                  "name": "Melting Pot",
                  "description": "Lorem ipsum",
                  "pictureId": "14",
                  "city": "Medan",
                  "rating": 4.2
                }
              ]
            }
            ''',
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      final provider = RestaurantProvider(client: mockClient);
      await provider.fetchRestaurantList();

      expect(provider.restaurantList, isA<ApiSuccess<List<Restaurant>>>());
      final result = provider.restaurantList as ApiSuccess<List<Restaurant>>;
      expect(result.data.length, 1);
      expect(result.data.first.name, 'Melting Pot');
    });

    test('mengembalikan error saat pengambilan data API gagal', () async {
      final mockClient = MockClient((_) async {
        throw Exception('Network error');
      });

      final provider = RestaurantProvider(client: mockClient);
      await provider.fetchRestaurantList();

      expect(provider.restaurantList, isA<ApiError<List<Restaurant>>>());
      final result = provider.restaurantList as ApiError<List<Restaurant>>;
      expect(
        result.message,
        'Tidak dapat memuat daftar restoran. Periksa koneksi internet Anda.',
      );
    });
  });
}
