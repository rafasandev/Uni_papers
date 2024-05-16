import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                children: [
                  for (var i = 0; i < articles.length; i++)
                    ArticleWidget(article: articles[i])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
