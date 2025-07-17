import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/models/user_model.dart';
import 'package:movies_application/modules/favorites_screen.dart';
import 'package:movies_application/modules/home_screen.dart';
import 'package:movies_application/modules/login_screen.dart';
import 'package:movies_application/modules/movies_screen.dart';
import 'package:movies_application/modules/profile_screen.dart';
import 'package:movies_application/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:movies_application/shared/network/endpoints.dart';
import 'package:movies_application/shared/network/tmdb_service.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  List<String> titles = ['Home', 'Favorites', 'Profile'];

  List<Widget> get screens => [
    MoviesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      MoviesScreen();
    }
    if (index == 1) {
      FavoritesScreen();
    }
    if (index == 2) {
      ProfileScreen();
    }
    emit(MoviesChangeBottomNavBarState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(MoviesChangeBottomNavBarState());
  }

  void changeFavorite() {
    isFavorite = !isFavorite;
    emit(MoviesChangeFavoriteState());
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(MoviesChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(MoviesLoginSucessState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(MoviesLoginLoadingState());
          final uid = value.user!.uid;
          print('User ID: $uid');
          getUserData(uid, context);
        })
        .catchError((error) {
          emit(MoviesLoginErrorState(error.toString()));
          Fluttertoast.showToast(
            msg: "Login Failed, Try Again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
  }

  void userSignout({required context}) async {
    emit(MoviesLogoutLoadingState());
    await FirebaseAuth.instance
        .signOut()
        .then((value) {
          emit(MoviesLogoutSucessState());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          currentIndex = 0;
        })
        .catchError((error) {
          emit(MoviesLogoutErrorState(error.toString()));
        });
  }

  String? userName;
  UserModel? user;

  void getUserData(id, context) {
    emit(MoviesUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
          user = UserModel.fromJson(value.data()!);
          print('Fetched User: ${user!.username}, ID: ${user!.id}');
          emit(MoviesUserDataSucessState());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        })
        .catchError((error) {
          debugPrint(error.toString());

          emit(MoviesUserDataErrorState(error.toString()));
        });
  }

  void updateUserData({required id, required username, required email}) {
    user = UserModel(id: id, username: username, email: email);
    emit(MoviesUserUpdateDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(user!.toJson())
        .then((value) {
          emit(MoviesUserUpdateDataSucessState());
          Fluttertoast.showToast(
            msg: "$username Updated Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        })
        .catchError((error) {
          emit(MoviesUserUpdateDataErrorState(error));
          Fluttertoast.showToast(
            msg: "$username Not Updated, Try Again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
  }

  List<dynamic> trendingMovies = [];

  void fetchTrendingMovies() async {
    emit(MoviesGetTrendingMoviesLoadingState());
    try {
      final movies = trendingMovies = await TMDBService().getTrendingMovies();
      trendingMovies = movies;
      emit(MoviesGetTrendingMoviesSucessState());
    } catch (error) {
      emit(MoviesGetTrendingMoviesErrorState(error.toString()));
    }
  }

  List<dynamic> genres = [];

  Future<void> fetchGenres() async {
    emit(MoviesGetGenresLoadingState());
    try {
      final service = TMDBService();
      final data = await service.getMovieGenres();
      genres = data;
      emit(MoviesGetGenresSucessState());
    } catch (error) {
      emit(MoviesGetGenresErrorState(error.toString()));
    }
  }

  void addToFavorites({required int movieId, required String title}) {
    emit(MoviesAddedToUserLoadingState());
    if (user?.id == null) {
      emit(MoviesAddedToUserErrorState('User ID is null'));
      return;
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .update({
          'favorites': FieldValue.arrayUnion([movieId]),
        })
        .then((value) {
          emit(MoviesAddedToUserSucessState());
          print('ADDED');
          Fluttertoast.showToast(
            msg: "$title Added to Favorites!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        })
        .catchError((error) {
          emit(MoviesAddedToUserErrorState(error.toString()));
        });
  }

  List<Map<String, dynamic>> favorites = [];

  void fetchFavorites() async {
    emit(MoviesGetFavoriteDataLoadingState());

    if (user?.id == null) {
      emit(MoviesGetFavoriteDataErrorState('User ID is null'));
      return;
    }

    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.id)
              .get();

      List<dynamic> favoriteIds = doc.data()?['favorites'] ?? [];

      List<Map<String, dynamic>> favoriteMovies = [];

      final tmdbService = TMDBService();

      for (var id in favoriteIds) {
        try {
          final movie = await tmdbService.getMovieById(id);
          favoriteMovies.add(movie);
        } catch (error) {
          emit(MoviesGetFavoriteDataErrorState(error.toString()));
        }
      }

      favorites = favoriteMovies;
      emit(MoviesGetFavoriteDataSucessState());
    } catch (error) {
      emit(MoviesGetFavoriteDataErrorState(error.toString()));
    }
  }

  void removeSelectedMovie({required id}) {
    emit(MoviesRemoveFavoriteDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .update({
          'favorites': FieldValue.arrayRemove([id]),
        })
        .then((value) {
          emit(MoviesRemoveFavoriteDataSucessState());
        })
        .catchError((error) {
          emit(MoviesRemoveFavoriteDataErrorState(error.toString()));
        });
  }

  List<Map<String, dynamic>> searchResults = [];
  void searchMovies(String query) async {
    emit(MoviesSearchLoadingState());
    if (query.isEmpty) {
      searchResults = [];
      emit(MoviesSearchSuccessState());
      return;
    }
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/search/movie',
        queryParameters: {'api_key': apiKey, 'query': query},
      );

      searchResults = List<Map<String, dynamic>>.from(response.data['results']);
      emit(MoviesSearchSuccessState());
    } catch (error) {
      emit(MoviesSearchErrorState(error.toString()));
    }
  }
}
