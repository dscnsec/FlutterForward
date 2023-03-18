import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login user'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                AbsorbPointer(
                  absorbing: _isLoading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        'assets/dash.png',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: 'Email', border: InputBorder.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                hintText: 'Password', border: InputBorder.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            String errorMessage = 'Something Went Wrong!';
                            setState(() {
                              _isLoading = true;
                            });

                            _auth
                                .signInWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password:
                                        _passwordController.text.toString())
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'Home', (route) => false);
                            }).catchError((error) {
                              setState(() {
                                _isLoading = false;
                              });
                              switch (error.code) {
                                case "invalid-email":
                                  errorMessage = "Invalid Email Provided";
                                  break;
                                case "user-not-found":
                                  errorMessage =
                                      "There is no user corresponding to the given email";
                                  break;
                                case "wrong-password":
                                  errorMessage =
                                      "Password is invalid for the given email";
                                  break;
                                default:
                                  errorMessage = "An undefined Error happened.";
                              }
                              debugPrint(error.code);
                              showToast(errorMessage);
                            });
                          },
                          child: const Text('Login')),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'Register');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent, fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                if (_isLoading)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
