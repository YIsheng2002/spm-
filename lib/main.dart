import 'package:flutter/material.dart';

import 'package:testing/screens/analysis.dart';
import 'package:testing/screens/home.dart';
import 'package:testing/screens/subject.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  List<Widget> _screen = [Home(), Analysis(),Subject()];
  int _selectedIndex = 0;
  String _title ="spm+";

  void _onPageChanged(int index) {
    setState(() {

      _selectedIndex = index;
      _changeTitle();
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }
  void _changeTitle(){
    if(_selectedIndex==0){
      setState(() {
        _title = "SPM+";
      });
    }

    else if(_selectedIndex==1){
      setState(() {
        _title = "Analysis";
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_title),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        indicatorColor: Colors.lightBlue,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_graph),
            label: 'Analytics',
          ),
          NavigationDestination(

            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
          NavigationDestination(

            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}





