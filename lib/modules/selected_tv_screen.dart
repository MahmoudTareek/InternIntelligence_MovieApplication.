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
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              var cubit = MoviesCubit.get(context);
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
                      padding: const EdgeInsets.all(8.0),
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
                                'Category: ${tv['genres'][0]['name']}, ${tv['genres'][1]['name']}',
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
                                'Language: ${tv['spoken_languages'][0]['name']}',
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
