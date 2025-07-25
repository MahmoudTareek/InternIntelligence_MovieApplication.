import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/modules/selected_movie_screen.dart';
import 'package:movies_application/shared/components.dart';
import 'package:movies_application/shared/styles/iconly_broken.dart';

class SreachScreen extends StatelessWidget {
  const SreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    var cubit = MoviesCubit.get(context);
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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(IconlyBroken.arrowLeft, color: secondryColor),
              onPressed: () {
                Navigator.pop(context);
                cubit.searchResults.clear();
              },
            ),
            title: Text(
              'Search Movies',
              style: TextStyle(
                color: secondryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.black87,
          ),
          backgroundColor: Colors.black87,
          body: BlocConsumer<MoviesCubit, MoviesState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                      context: context,
                      controller: searchController,
                      type: TextInputType.text,
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          cubit.searchMovies(value);
                        }
                        if (value.isEmpty) {
                          cubit.searchResults.clear();
                        }
                      },
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a movie name';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                  ),
                  if (cubit.searchResults.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.manage_search,
                            size: 100,
                            color: secondryColor,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Searching for a movie?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: secondryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (cubit.searchResults.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: cubit.searchResults.length,
                        itemBuilder: (context, index) {
                          final movie = cubit.searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          SelectedMovieScreen(Id: movie['id']),
                                        );
                                      },
                                      child: Container(
                                        width: 185,
                                        child: Column(
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                movie['poster_path'] != null
                                                    ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                                                    : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
                                              ),
                                              width: 185,
                                              height: 240,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              movie['title'] ?? 'No Title',
                                              style: TextStyle(
                                                color: secondryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              movie['release_date'] ?? '',
                                              style: TextStyle(
                                                color: secondryColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
