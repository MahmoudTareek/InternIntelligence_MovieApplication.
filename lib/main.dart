import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/modules/home_Screen.dart';
import 'package:movies_application/modules/login_screen.dart';
import 'package:movies_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              MoviesCubit()
                ..fetchGenres()
                ..fetchTrendingMovies()
                ..fetchTopRatedMovies()
                ..fetchUpcomingMovies()
                ..fetchMovies()
                ..fetchTv()
                ..fetchFavorites(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
