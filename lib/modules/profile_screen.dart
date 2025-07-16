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
                        'https://painrehabproducts.com/wp-content/uploads/2014/10/facebook-default-no-profile-pic.jpg',
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
                              id: cubit.userID.toString(),
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
