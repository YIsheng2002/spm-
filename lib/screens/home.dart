import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/bottomNavbar/bottomNavBar.dart';
import 'package:testing/screens/analysis.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {

  PageController _pageController = PageController();
  List<Widget> _screen = [Analysis()];
  int _selectedIndex =0;

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex =index;
    });

  }
  void _onItemTapped (int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Column(
            children: [
              Text("Home",
                style: TextStyle(fontSize: 60),)
            ],
          ),
        )
         
      );

  }
}