import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
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