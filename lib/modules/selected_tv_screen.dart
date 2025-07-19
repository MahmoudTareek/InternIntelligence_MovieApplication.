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
              final tv = cubit.selectedTv;
              if (tv == null) {
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
                          'https://image.tmdb.org/t/p/w500${tv['poster_path']}',
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
                          tv['name'],
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
                                    (tv['genres'].length > 0
                                        ? tv['genres'][0]['name']
                                        : 'N/A') +
                                    (tv['genres'].length > 1
                                        ? ', ${tv['genres'][1]['name']}'
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
                                'Language: ${tv['spoken_languages'].isNotEmpty ? tv['spoken_languages'][0]['name'] : 'Unknown'}',
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
                                'Rating: ${tv['vote_average'].toStringAsFixed(1)}',
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
                        tv['overview'],
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
                                    movieID: tv['id'].toString(),
                                    reveiw: reviewController.text,
                                    username: cubit.user?.username.toString(),
                                  );
                                  Future.delayed(
                                    Duration(milliseconds: 100),
                                    () {
                                      MoviesCubit.get(context).getUserReveiw(
                                        movieID: tv['id'].toString(),
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
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
