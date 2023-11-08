import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuBottom extends StatefulWidget {
  const MenuBottom({super.key});

  @override
  State<MenuBottom> createState() => _MenuBottomState();
}

class _MenuBottomState extends State<MenuBottom> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 24,
        showUnselectedLabels: false,

        currentIndex: currentIndex,
        //onTap: (index) => setState(() => currentIndex = index),
        onTap: (int index)
        {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Analytics',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
            backgroundColor: Colors.blue,
          ),
        ]
    );
  }
}



