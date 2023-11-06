import 'package:flutter/material.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';

class Subject extends StatefulWidget {
  const Subject({super.key});

  @override
  State<Subject> createState() => _MyAppState();
}

class _MyAppState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: const Center(
          child: Text('Subject',
            style: TextStyle(fontSize: 60),
          ),
        ),

    );
  }
}