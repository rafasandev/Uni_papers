import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unipapers_project/utils/colors.dart';
import 'package:unipapers_project/utils/courses_list.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BottomBarComponent extends StatefulWidget {
  const BottomBarComponent({super.key});

  @override
  State<BottomBarComponent> createState() => _BottomBarComponentState();
}

class _BottomBarComponentState extends State<BottomBarComponent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        if (value == 0) {
          Navigator.pushNamed(context, '/home_page');
        }
        if (value == 1) {
          Navigator.pushNamed(context, '/search_page');
        }
        if (value == 2) {
          Navigator.pushNamed(context, '/profile_page');
        }
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
    );
  }
}
