import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit(),
      child: BlocConsumer<MoviesCubit, MoviesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
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
                          height: 150,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (context, index) => GestureDetector(
                                  onTap: () {
                                    print('Category Clicked: $index');
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                            'https://painrehabproducts.com/wp-content/uploads/2014/10/facebook-default-no-profile-pic.jpg',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Category $index',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                            separatorBuilder:
                                (context, index) => SizedBox(width: 10),
                            itemCount: 7,
                          ),
                        ),
                      ],
                    ),
                    itemBuilder(
                      favorite: Icons.favorite,
                      onTap: (index) {
                        print('Trending Movies Clicked: $index');
                      },
                      icon: Icons.trending_up,
                      text: 'Trending',
                      imageUrl:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPrvnm34EFXIQVMbSYNbBEmP5hUUIW2abNRw&s',
                      itemCount: 10,
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
      ),
    );
  }
}
