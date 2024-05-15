// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/article.dart';
import 'package:unipapers_project/utils/colors.dart';

import '../models/components/article_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Pesquise por um artigo"),
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Row(
                      children: [
                        Text(
                          "Resultados para: ",
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Resultado",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  for (var i = 0; i < articles.length; i++)
                    ArticleWidget(article: articles[i])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
