import 'package:dio/dio.dart';
import 'endpoints.dart';

class TMDBService {
  final Dio _dio = Dio();

  Future<List<dynamic>> getTrendingMovies() async {
    final response = await _dio.get(
      '$baseUrl/trending/movie/day',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<dynamic>> getMovieGenres() async {
    final response = await _dio.get(
      '$baseUrl/genre/movie/list',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['genres'];
    } else {
      throw Exception('Failed to load movie genres');
    }
  }
}
