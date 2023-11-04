import 'package:flutter/material.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('spm+'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Home',
          style: TextStyle(fontSize: 60),
          ),
        ),
        bottomNavigationBar: const MenuBottom(),
      ),
    );
  }
}



