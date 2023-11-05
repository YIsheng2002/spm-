import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _MyAppState();
}

class _MyAppState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('spm+'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Analysis',
            style: TextStyle(fontSize: 60),
          ),
        ),
      ),
    );
  }
}