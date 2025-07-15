import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
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
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                label: 'email',
                prefix: Icons.email,
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: defaultButton(
                      function: () {
                        // MoviesCubit.get(context).logout();
                        Navigator.pop(context);
                      },
                      text: 'update',
                      background: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: defaultButton(
                      function: () {
                        // MoviesCubit.get(context).logout();
                        Navigator.pop(context);
                      },
                      text: 'Logout',
                      background: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
