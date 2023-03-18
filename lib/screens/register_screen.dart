import 'package:chatapp/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../handlers/auth_hander.dart';
import '../model/user_model.dart' as user;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final authHandler = AuthHandeler();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Register user'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: 'Name', border: InputBorder.none),
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
                          controller: _usernameController,
                          decoration: InputDecoration(
                              hintText: 'Username', border: InputBorder.none),
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
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: 'email', border: InputBorder.none),
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
                          setState(() {
                            _isLoading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text.toString(),
                                  password: _passwordController.text.toString())
                              .then((value) {
                            authHandler.registerUser(
                                user: user.User(
                              email: _emailController.text.toString(),
                              name: _nameController.text.toString(),
                              createdAt: DateTime.now().toLocal().toString(),
                              updatedAt: DateTime.now().toLocal().toString(),
                              username: _usernameController.text.toString(),
                            ));
                            showToast(
                                "User registered successfully, Login now!");
                            Navigator.pushNamed(context, 'Login');
                          }).catchError((error) {
                            String errorMessage = 'Something Went Wrong!';
                            switch (error.code) {
                              case "email-already-in-use":
                                errorMessage =
                                    "Email is already in use on different account";
                                break;
                              default:
                                errorMessage = "An undefined Error happened.";
                            }
                            debugPrint(error.code);
                            showToast(errorMessage);
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        },
                        child: const Text('Register')),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'Login');
                          },
                          child: const Text(
                            'Login',
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
    );
  }
}
