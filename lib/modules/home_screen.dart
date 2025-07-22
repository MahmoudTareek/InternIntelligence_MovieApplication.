import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/modules/search_screen.dart';
import 'package:movies_application/shared/components.dart';
import 'package:movies_application/shared/styles/iconly_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: TextStyle(
                color: secondryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: IconButton(
                  icon: Icon(IconlyBroken.search, color: secondryColor),
                  onPressed: () {
                    navigateTo(context, SreachScreen());
                  },
                ),
              ),
            ],
            backgroundColor: Colors.black,
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            selectedItemColor: primaryColor,
            unselectedItemColor: secondryColor,
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
