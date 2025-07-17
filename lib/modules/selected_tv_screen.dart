import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class SelectedTVScreen extends StatelessWidget {
  final Id;

  const SelectedTVScreen({Key? key, required this.Id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      MoviesCubit.get(context).getSelectedTv(id: Id);
    });
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: secondryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Selected TV Show',
              style: TextStyle(
                color: secondryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.black,
          ),
          body: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              var cubit = MoviesCubit.get(context);
              // MoviesCubit.get(context).getSelectedMovie(id: movieId);
              final tv = cubit.selectedTv;
              // print(movie);
              if (tv == null) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500${tv['poster_path']}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 600,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        tv['name'],
                        style: TextStyle(
                          color: secondryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        tv['overview'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    //
  }
}
