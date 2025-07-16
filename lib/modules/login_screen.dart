//login screen
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_application/cubit/cubit.dart';
import 'package:movies_application/cubit/states.dart';
import 'package:movies_application/modules/home_screen.dart';
import 'package:movies_application/shared/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://s3.us-west-1.amazonaws.com/redwood-labs/showpage/uploads/images/9c8ede6c-056e-474d-870c-8b0ec386ae8a.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.black45,
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: secondryColor,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Login now to watch your favorite movies',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: secondryColor,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            defaultFormField(
                              context: context,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                              label: 'Email Address',
                              prefix: Icons.email,
                            ),
                            const SizedBox(height: 20.0),
                            defaultFormField(
                              context: context,
                              controller: passwordController,
                              suffix:
                                  isPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                              suffixPrssed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              type: TextInputType.visiblePassword,
                              isPassword: isPassword,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Password must not be empty';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock,
                            ),
                            const SizedBox(height: 20.0),
                            defaultButton(
                              function: () {
                                // navigateTo(context, HomeScreen());
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => HomeScreen(),
                                //   ),
                                // );
                                if (formKey.currentState!.validate()) {
                                  MoviesCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                }
                              },
                              text: 'login',
                              radius: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
