import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';


void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Splash',
      routes: {
        'Splash': (context) => const SplashScreen(),
        'Login': (context) =>  LoginScreen(),
        'Register': (context) =>  RegisterScreen(),
        'Home': (context) =>  HomeScreen(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutterfire'),
        ),
      ),
    );
  }
}