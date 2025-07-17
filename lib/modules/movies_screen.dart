import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        if (cubit.genres.isEmpty || cubit.trendingMovies.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryColor));
        }
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
                    favorite: Icons.favorite,
                    onTap: (index) {
                      print('Tapped: ${cubit.trendingMovies[index]['title']}');
                      print('Tapped: ${cubit.trendingMovies[index]['id']}');
                      print('uID : ${cubit.user?.id.toString()}');
                      MoviesCubit.get(context).addToFavorites(
                        movieId: cubit.trendingMovies[index]['id'],
                      );
                    },
                    icon: Icons.trending_up,
                    text: 'Trending',
                    imageUrl: '',
                    customItemBuilder: (index) {
                      final movie = cubit.trendingMovies[index];
                      return {
                        'imageUrl':
                            movie['poster_path'] != null
                                ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                                : 'https://via.placeholder.com/150',
                      };
                    },
                    itemCount: cubit.trendingMovies.length,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    favorite: Icons.favorite,
                    onTap: (index) {
                      print('Top Rated Movies Clicked: $index');
                    },
                    icon: Icons.replay,
                    text: 'Continues Watching',
                    imageUrl:
                        'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg',
                    itemCount: 10,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    favorite: Icons.favorite,
                    onTap: (index) {
                      print('Movies Clicked: $index');
                    },
                    icon: Icons.movie,
                    text: 'Movies',
                    imageUrl:
                        'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg',
                    itemCount: 10,
                  ),
                  SizedBox(height: 20),
                  itemBuilder(
                    favorite: Icons.favorite,
                    onTap: (index) {
                      print('Series Clicked: $index');
                    },
                    icon: Icons.tv,
                    text: 'Series',
                    imageUrl:
                        'https://m.media-amazon.com/images/M/MV5BYzYyN2FiZmUtYWYzMy00MzViLWJkZTMtOGY1ZjgzNWMwN2YxXkEyXkFqcGc@._V1_.jpg',
                    itemCount: 10,
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
