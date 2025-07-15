import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class SreachScreen extends StatelessWidget {
  const SreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: secondryColor),
          onPressed: () {
            Navigator.pop(context);
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
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormField(
                  context: context,
                  controller: searchController,
                  type: TextInputType.text,
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
              SizedBox(height: 250),
              Icon(Icons.manage_search, size: 100, color: secondryColor),
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
      ),
    );
  }
}
