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
        // var selectedGenre = null;
        Color color = Colors.white;
        if (cubit.genres.isEmpty || cubit.trendingMovies.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }
        MoviesCubit.get(context).fetchFavorites();
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Coverr.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.black87,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                          MoviesCubit.get(context).getUserReveiw(
                            movieID:
                                cubit.trendingMovies[index]['id'].toString(),
                          );
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
                        onFavoriteTap: (index) {
                          MoviesCubit.get(context).addToFavorites(
                            Id: cubit.topRatedMovies[index]['id'],
                            title:
                                cubit.topRatedMovies[index]['title'] ??
                                'Unknown Title',
                            type: 'movie',
                          );
                        },
                        favorite: Icons.favorite,
                        onTap: (index) {
                          MoviesCubit.get(context).getUserReveiw(
                            movieID:
                                cubit.topRatedMovies[index]['id'].toString(),
                          );
                          navigateTo(
                            context,
                            SelectedMovieScreen(
                              Id: cubit.topRatedMovies[index]['id'],
                            ),
                          );
                        },
                        icon: Icons.star,
                        text: 'Top Rated',
                        imageUrl: '',
                        customItemBuilder: (index) {
                          final movie = cubit.topRatedMovies[index];
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
                        itemCount: cubit.topRatedMovies.length,
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
                          MoviesCubit.get(context).getUserReveiw(
                            movieID: cubit.movies_list[index]['id'].toString(),
                          );
                          navigateTo(
                            context,
                            SelectedMovieScreen(
                              Id: cubit.movies_list[index]['id'],
                            ),
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
                            title:
                                cubit.tv_list[index]['name'] ?? 'Unknown Title',
                            type: 'tv',
                          );
                        },
                        favorite: Icons.favorite,
                        onTap: (index) {
                          MoviesCubit.get(context).getUserReveiw(
                            movieID: cubit.tv_list[index]['id'].toString(),
                          );
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
                      SizedBox(height: 20),
                      itemBuilder(
                        onFavoriteTap: (index) {
                          MoviesCubit.get(context).addToFavorites(
                            Id: cubit.upComingMovies[index]['id'],
                            title:
                                cubit.upComingMovies[index]['title'] ??
                                'Unknown Title',
                            type: 'movie',
                          );
                        },
                        favorite: Icons.favorite,
                        onTap: (index) {
                          MoviesCubit.get(context).getUserReveiw(
                            movieID:
                                cubit.upComingMovies[index]['id'].toString(),
                          );
                          navigateTo(
                            context,
                            SelectedMovieScreen(
                              Id: cubit.upComingMovies[index]['id'],
                            ),
                          );
                        },
                        icon: Icons.update,
                        text: 'Upcoming',
                        imageUrl: '',
                        customItemBuilder: (index) {
                          final movie = cubit.upComingMovies[index];
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
                        itemCount: cubit.upComingMovies.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
