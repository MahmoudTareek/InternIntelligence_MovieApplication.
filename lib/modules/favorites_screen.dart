import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        MoviesCubit.get(context).fetchFavorites();
        var cubit = MoviesCubit.get(context);
        if (cubit.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.heart_broken, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'No Favorites Yet!',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cubit.favorites.length,
                  itemBuilder: (context, index) {
                    final movie = cubit.favorites[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 180,
                                width: 130,
                                child: Image(
                                  image: NetworkImage(
                                    movie['poster_path'] != null
                                        ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                                        : 'https://via.placeholder.com/150',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      '${movie['title'] ?? 'Unknown Title'}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: secondryColor,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      '${movie['overview'] ?? 'No Overview Available'}',
                                      style: TextStyle(
                                        color: secondryColor,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 8.0,
                                  top: 50.0,
                                ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      print('DELETED');
                                      MoviesCubit.get(
                                        context,
                                      ).removeSelectedMovie(id: movie['id']);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
