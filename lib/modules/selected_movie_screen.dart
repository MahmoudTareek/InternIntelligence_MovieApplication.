import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class SelectedMovieScreen extends StatefulWidget {
  var Id;

  SelectedMovieScreen({Key? key, required this.Id}) : super(key: key);

  @override
  State<SelectedMovieScreen> createState() => _SelectedMovieScreenState();
}

class _SelectedMovieScreenState extends State<SelectedMovieScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = MoviesCubit.get(context);
    cubit.getRecommendationMovies(movie_id: widget.Id);
    cubit.getSelectedMovie(id: widget.Id);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MoviesCubit.get(context);
    var reviewController = TextEditingController();
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black45,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: secondryColor),
                  onPressed: () {
                    Navigator.pop(context);
                    cubit.allReviews.clear();
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              final movie = cubit.selectedMovie;
              if (movie == null) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 600,
                        ),
                        Container(
                          width: double.infinity,
                          height: 600,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black26, Colors.transparent],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Center(
                        child: Text(
                          movie['title'],
                          style: TextStyle(
                            color: secondryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.movie_creation_outlined,
                                color: secondryColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Category: ' +
                                    (movie['genres'].length > 0
                                        ? movie['genres'][0]['name']
                                        : 'N/A') +
                                    (movie['genres'].length > 1
                                        ? ', ${movie['genres'][1]['name']}'
                                        : ''),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.language, color: secondryColor),
                              SizedBox(width: 5),
                              Text(
                                'Language: ${movie['spoken_languages'].isNotEmpty ? movie['spoken_languages'][0]['name'] : 'Unknown'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star_rate, color: Colors.yellow[700]),
                              SizedBox(width: 5),
                              Text(
                                'Rating: ${movie['vote_average'].toStringAsFixed(1)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        movie['overview'],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                        context: context,
                        controller: reviewController,
                        type: TextInputType.text,
                        validate: ((value) {
                          if (value.isEmpty) {
                            return 'Please enter your review';
                          }
                          return null;
                        }),
                        label: 'Review',
                        prefix: Icons.reviews,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 10.0),
                          child: Container(
                            width: 150.0,
                            child: defaultButton(
                              function: () {
                                if (reviewController.text.isNotEmpty) {
                                  cubit.addUserReveiw(
                                    movieID: movie['id'].toString(),
                                    reveiw: reviewController.text,
                                    username: cubit.user?.username.toString(),
                                  );
                                  Future.delayed(
                                    Duration(milliseconds: 100),
                                    () {
                                      MoviesCubit.get(context).getUserReveiw(
                                        movieID: movie['id'].toString(),
                                      );
                                    },
                                  );
                                }
                              },
                              text: 'Add a Review',
                              background: primaryColor,
                              radius: 50.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (cubit.allReviews.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Reviews:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          for (int i = 0; i < cubit.allReviews.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.0),
                                  IgnorePointer(
                                    child: TextFormField(
                                      initialValue:
                                          cubit.allReviews[i]['review'],
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelText:
                                            cubit.allReviews[i]['username'] ??
                                            'Anonymous',
                                        labelStyle: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommended Movies:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 250.0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        cubit.recommendationsMovies.length,
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(width: 10.0),
                                    itemBuilder: (context, index) {
                                      final recommendedMovie =
                                          cubit.recommendationsMovies[index];
                                      return GestureDetector(
                                        onTap: () {
                                          cubit.allReviews.clear();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => SelectedMovieScreen(
                                                    Id: recommendedMovie['id'],
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120.0,
                                              height: 180.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${recommendedMovie['poster_path']}',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              width: 120.0,
                                              child: Text(
                                                recommendedMovie['title'] ??
                                                    'Unknown Title',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
