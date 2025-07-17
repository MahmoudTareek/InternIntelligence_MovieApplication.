import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/modules/selected_movie_screen.dart';
import 'package:movies_application/modules/selected_tv_screen.dart';
import 'package:movies_application/shared/components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        Color color = Colors.white;
        if (cubit.genres.isEmpty || cubit.trendingMovies.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }
        MoviesCubit.get(context).fetchFavorites();
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list, color: Colors.white, size: 30),
                          SizedBox(width: 10),
                          Text(
                            'Movies Categories',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 54,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final genre = cubit.genres[index];
                            return Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                  ),
                                  onPressed: () {
                                    print('Category Clicked: ${genre['name']}');
                                  },
                                  child: Text(
                                    '${genre['name']}',
                                    style: TextStyle(color: secondryColor),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(width: 10),
                          itemCount: cubit.genres.length,
                        ),
                      ),
                    ],
                  ),
                  itemBuilder(
                    onFavoriteTap: (index) {
                      MoviesCubit.get(context).addToFavorites(
                        Id: cubit.trendingMovies[index]['id'],
                        title:
                            cubit.trendingMovies[index]['title'] ??
                            'Unknown Title',
                        type: 'movie',
                      );
                    },
                    favorite: Icons.favorite,
                    onTap: (index) {
                      navigateTo(
                        context,
                        SelectedMovieScreen(
                          Id: cubit.trendingMovies[index]['id'],
                        ),
                      );
                    },
                    icon: Icons.trending_up,
                    text: 'Trending',
                    imageUrl: '',
                    customItemBuilder: (index) {
                      final movie = cubit.trendingMovies[index];
                      // final movie = cubit.favorites[index];
                      bool isFavorite = cubit.favorites.any(
                        (fav) => fav['id'] == movie['id'],
                      );
                      return {
                        'imageUrl':
                            movie['poster_path'] != null
                                ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                                : 'https://via.placeholder.com/150',
                        'color': isFavorite ? primaryColor : secondryColor,
                      };
                    },
                    itemCount: cubit.trendingMovies.length,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    onFavoriteTap: (index) {},
                    color: color,
                    favorite: Icons.favorite,
                    onTap: (index) {
                      print('Movies Clicked: $index');
                    },
                    icon: Icons.play_circle_fill,
                    text: 'Continue Watching',
                    imageUrl:
                        'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg',
                    itemCount: 10,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    onFavoriteTap: (index) {
                      MoviesCubit.get(context).addToFavorites(
                        Id: cubit.movies_list[index]['id'],
                        title:
                            cubit.movies_list[index]['title'] ??
                            'Unknown Title',
                        type: 'movie',
                      );
                    },
                    favorite: Icons.favorite,
                    onTap: (index) {
                      navigateTo(
                        context,
                        SelectedMovieScreen(Id: cubit.movies_list[index]['id']),
                      );
                    },
                    icon: Icons.movie,
                    text: 'Movies',
                    imageUrl: '',
                    customItemBuilder: (index) {
                      final movie = cubit.movies_list[index];
                      // final movie = cubit.favorites[index];
                      bool isFavorite = cubit.favorites.any(
                        (fav) => fav['id'] == movie['id'],
                      );
                      return {
                        'imageUrl':
                            movie['poster_path'] != null
                                ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                                : 'https://via.placeholder.com/150',
                        'color': isFavorite ? primaryColor : secondryColor,
                      };
                    },
                    itemCount: cubit.movies_list.length,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    onFavoriteTap: (index) {
                      print('TV : ${cubit.tv_list[index]['id']}');
                      MoviesCubit.get(context).addToFavorites(
                        Id: cubit.tv_list[index]['id'],
                        title: cubit.tv_list[index]['name'] ?? 'Unknown Title',
                        type: 'tv',
                      );
                    },
                    favorite: Icons.favorite,
                    onTap: (index) {
                      navigateTo(
                        context,
                        SelectedTVScreen(Id: cubit.tv_list[index]['id']),
                      );
                    },
                    icon: Icons.tv,
                    text: 'TV',
                    imageUrl: '',
                    customItemBuilder: (index) {
                      final tv = cubit.tv_list[index];
                      // final movie = cubit.favorites[index];
                      bool isFavorite = cubit.favorites.any(
                        (fav) => fav['id'] == tv['id'],
                      );
                      return {
                        'imageUrl':
                            tv['poster_path'] != null
                                ? 'https://image.tmdb.org/t/p/w500${tv['poster_path']}'
                                : 'https://via.placeholder.com/150',
                        'color': isFavorite ? primaryColor : secondryColor,
                      };
                    },
                    itemCount: cubit.tv_list.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
