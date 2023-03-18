import 'package:animated_drawer/pages/drawerpage.dart';
import 'package:animated_drawer/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  final double maxSlide = 225.0;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
  }

  void toggle() => animationController!.isDismissed ? animationController!.forward() : animationController!.reverse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: toggle,
        child: AnimatedBuilder(
            animation: animationController!,
            builder: (context, _) {
              double slide = maxSlide * animationController!.value;
              double scale = 1 - (animationController!.value * 0.3);
              return Stack(children: [
                const DrawerPage(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(animationController!.value * 10), child: const MyHomePage()),
                ),
              ]);
            }),
      ),
    );
  }
}
