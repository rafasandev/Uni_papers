import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/pages/article_creation_page.dart';
import '/pages/cadastro_page.dart';
import '/pages/edit_profile_page.dart';
import '/pages/login_page.dart';
import '/pages/main_page.dart';
import '/pages/single_article_page.dart';
import '/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/single_article_page': (context) => const SingleArticlePage(),
        '/edit_profile': (context) => const EditProfilePage(),
        '/create_article': (context) => const ArticleCreationPage()
      },
    );
  }
}
