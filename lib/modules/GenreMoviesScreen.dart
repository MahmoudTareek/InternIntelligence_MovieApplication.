import 'package:flutter/material.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/modules/selected_movie_screen.dart';
import 'package:movies_application/shared/components.dart';

class GenreMoviesScreen extends StatelessWidget {
  final List<dynamic> genreMovies;
  const GenreMoviesScreen({super.key, required this.genreMovies});

  @override
  Widget build(BuildContext context) {
    final cubit = MoviesCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(genreMovies[0], style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
          cubit.genreMovies!.isEmpty
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : ListView.builder(
                itemCount: cubit.genreMovies!.length,
                itemBuilder: (context, index) {
                  final movie = cubit.genreMovies![index];
                  return ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      width: 50,
                    ),
                    title: Text(
                      movie['title'] ?? 'Unknown Title',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      navigateTo(context, SelectedMovieScreen(Id: movie['id']));
                    },
                  );
                },
              ),
    );
  }
}
