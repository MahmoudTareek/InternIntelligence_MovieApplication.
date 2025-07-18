import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/modules/login_screen.dart';
import 'package:movies_application/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MoviesCubit.get(context);
        TextEditingController userNameController = TextEditingController(
          text: cubit.user?.username.toString(),
        );
        TextEditingController emailController = TextEditingController(
          text: cubit.user?.email.toString(),
        );
        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://wallpapers.com/images/hd/netflix-profile-pictures-1000-x-1000-qo9h82134t9nv0j0.jpg',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  defaultFormField(
                    context: context,
                    controller: userNameController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    label: 'User Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    context: context,
                    controller: emailController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          function: () {
                            MoviesCubit.get(context).updateUserData(
                              id: cubit.user?.id.toString(),
                              username: userNameController.text,
                              email: emailController.text,
                            );
                          },
                          text: 'update',
                          background: Colors.blue,
                          radius: 50.0,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: defaultButton(
                          function: () {
                            MoviesCubit.get(
                              context,
                            ).userSignout(context: context);
                          },
                          text: 'Logout',
                          background: Colors.red,
                          radius: 50.0,
                        ),
                      ),
                    ],
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
