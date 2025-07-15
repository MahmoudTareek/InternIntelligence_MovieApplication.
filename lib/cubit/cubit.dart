import 'package:flutter/material.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/modules/favorites_screen.dart';
import 'package:movies_application/modules/movies_screen.dart';
import 'package:movies_application/modules/profile_screen.dart';
import 'package:movies_application/shared/components.dart';

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

  List<Widget> screens = [MoviesScreen(), FavoritesScreen(), ProfileScreen()];

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
    print('object');
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
}
