import 'package:flutter/material.dart';
import 'package:unipapers_project/pages/home_page.dart';
import 'package:unipapers_project/pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    Text(
      'Index 2: School',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          // if (value == 0) {
          //   Navigator.pushNamed(context, '/home_page');
          // }
          // if (value == 1) {
          //   Navigator.pushNamed(context, '/search_page');
          // }
          // if (value == 2) {
          //   Navigator.pushNamed(context, '/profile_page');
          // }
          setState(() {
            _currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
        currentIndex: _currentIndex,
      ),
    );
  }
}
