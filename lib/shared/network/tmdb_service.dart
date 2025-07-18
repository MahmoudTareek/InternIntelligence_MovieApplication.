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

  Future<List<dynamic>> getTopRatedMovies() async {
    final response = await _dio.get(
      '$baseUrl/movie/top_rated',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<dynamic>> getUpcomingMovies() async {
    final response = await _dio.get(
      '$baseUrl/movie/upcoming',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<dynamic>> getMovies() async {
    final response = await _dio.get(
      '$baseUrl/discover/movie',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> getTv() async {
    final response = await _dio.get(
      '$baseUrl/discover/tv',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data['results'];
    } else {
      throw Exception('Failed to load trending tv shows');
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

  Future<Map<String, dynamic>> getMovieById(int movieId) async {
    final response = await _dio.get(
      '$baseUrl/movie/$movieId',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load movie with ID $movieId');
    }
  }

  Future<Map<String, dynamic>> getTVById(int tvId) async {
    final response = await _dio.get(
      '$baseUrl/tv/$tvId',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load TV with ID $tvId');
    }
  }
}
