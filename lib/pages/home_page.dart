import 'package:flutter/material.dart';
import 'package:unipapers_project/models/components/bottom_appbar.dart';
import 'package:unipapers_project/models/entities/article.dart';

import '../models/components/article_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> articles = fecthArticles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
              child: Image.asset("lib/images/onlyHandsLogo.png"),
            ),
            for (var i = 0; i < articles.length; i++)
              ArticleWidget(article: articles[i])
          ],
        ),
      ),
      bottomNavigationBar: BottomBarComponent(),
    );
  }
}

List<Article> fecthArticles() {
  List<dynamic> data = [
    {
      "title": "A Importância da Inteligência Artificial na Medicina",
      "releaseDate": "2023-05-10",
      "authorsName": ["Maria Silva", "Carlos Oliveira"]
    },
    {
      "title": "Impacto das Mudanças Climáticas na Agricultura",
      "releaseDate": "2022-09-21",
      "authorsName": ["João Santos", "Ana Costa"]
    },
    {
      "title": "Avanços em Energias Renováveis",
      "releaseDate": "2024-03-15",
      "authorsName": ["Pedro Almeida", "Luana Mendes", "Rafaela Pereira"]
    },
    {
      "title": "Novas Descobertas na Exploração Espacial",
      "releaseDate": "2023-07-25",
      "authorsName": ["Fernanda Oliveira", "Lara Rodrigues"]
    },
    {
      "title": "Evolução das Tecnologias de Comunicação",
      "releaseDate": "2024-01-18",
      "authorsName": ["Daniel Silva", "Camila Sousa", "Gabriel Santos"]
    },
    {
      "title": "A Era da Robótica: Desafios e Oportunidades",
      "releaseDate": "2023-11-30",
      "authorsName": ["Carolina Lima", "Antônio Alves"]
    },
    {
      "title": "Inovações em Transporte Sustentável",
      "releaseDate": "2022-10-07",
      "authorsName": ["Laura Ferreira", "Ricardo Oliveira"]
    },
    {
      "title": "Impacto da Inteligência Artificial na Indústria",
      "releaseDate": "2023-08-11",
      "authorsName": ["Luiz Santos", "Isabela Costa"]
    },
    {
      "title": "Desenvolvimento de Medicamentos Personalizados",
      "releaseDate": "2024-04-22",
      "authorsName": ["Natália Pereira", "Pedro Almeida"]
    },
    {
      "title": "Influência da Internet das Coisas na Sociedade",
      "releaseDate": "2022-12-05",
      "authorsName": ["Gustavo Lima", "Maria Silva"]
    }
  ];

  List<Article> articles = data.map((item) {
    return Article(
      title: item['title'],
      releaseDate: item['releaseDate'],
      authorsName: List<String>.from(item['authorsName']),
    );
  }).toList();

  return articles;
}
