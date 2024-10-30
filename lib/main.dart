import 'package:flutter/material.dart';
import '/pages/article_creation_page.dart';
import '/pages/cadastro_page.dart';
import '/pages/edit_profile_page.dart';
import '/pages/login_page.dart';
import '/pages/main_page.dart';
import '/pages/single_article_page.dart';
import '/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Unipapers Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: blue),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const LoginPage(),
          '/cadastro_page': (context) => const CadastroPage(),
          '/main_page': (context) => const MainPage(),
          '/single_article_page': (BuildContext context) =>
              const SingleArticlePage(),
          '/edit_profile': (BuildContext context) => const EditProfilePage(),
          '/create_article': (BuildContext context) =>
              const ArticleCreationPage()
        },
      ),
    );
  }
}
