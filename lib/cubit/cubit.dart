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

  String? userID;

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
          userID = value.user!.uid;
          print('User ID: $userID');
          getUerData(userID, context);
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
          userID = null;
          currentIndex = 0;
        })
        .catchError((error) {
          emit(MoviesLogoutErrorState(error.toString()));
        });
  }

  String? userName;
  UserModel? user;

  void getUerData(id, context) {
    emit(MoviesUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
          user = UserModel.fromJson(value.data()!);
          print(user!.username.toString());
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
}
