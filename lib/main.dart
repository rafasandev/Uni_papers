import 'package:flutter/material.dart';
import 'package:unipapers_collab_proj/pages/cadastro_page.dart';
import 'package:unipapers_collab_proj/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => LoginPage(),
        '/cadastro_page': (context) => CadastroPage(),
      },
    );
  }
}
