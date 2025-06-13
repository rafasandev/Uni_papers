import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/pages/article_creation_page.dart';
import '/pages/cadastro_page.dart';
import '/pages/edit_profile_page.dart';
import '/pages/login_page.dart';
import '/pages/main_page.dart';
import '/pages/single_article_page.dart';
import '/utils/colors.dart';

/**
 * * Feito
 * TODO: Fazer hash de senhas para envio ao DB
 * * Fazendo
 * 
 * * A fazer
 * TODO: Colocar a pesquisa de escritores nos colaboradores
 * TODO: Inserir data de publicação e alterar na amostra do artigo
 * TODO: Fazer um botão de logout do usuário
 * TODO: Repensar tela de perfil do usuário
 * TODO: Colocar um timer para a pesquisa não pesar em reqs
 * TODO: Arrumar carregamento sempre que entra na tela da home page
*/
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,
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
