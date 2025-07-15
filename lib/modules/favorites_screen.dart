import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: 10,
              itemBuilder: (context, index) {
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
                                'https://upload.wikimedia.org/wikipedia/en/8/8f/Fast_and_Furious_Poster.jpg',
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
                                  'fast and furious',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: secondryColor,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  'BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA',
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  print('Item: $index Deleted');
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
  }
}
