import 'package:flutter/material.dart';
import 'package:unipapers_project/pages/home_page.dart';
import 'package:unipapers_project/pages/profile_page.dart';
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
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Center(child: Builder(builder: (context) {
        if (_currentIndex == 0) {
          return HomePage();
        }
        if (_currentIndex == 1) {
          return SearchPage();
        }
        if (_currentIndex == 2) {
          return ProfilePage(
            user: user,
          );
        }
        return Text("Erro");
      })),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
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
            label: "Pesquisa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Perfil",
          ),
        ],
        currentIndex: _currentIndex,
      ),
    );
  }
}
