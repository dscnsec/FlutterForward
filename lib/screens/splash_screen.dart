import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_auth.currentUser == null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'Login');
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'Home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/dash.png',
            ),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 50,
            ),
            const Text('Welcome to Dash Chat',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 50,
            ),
            const Text("Developed with ❤️ by @APP LEADS",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
