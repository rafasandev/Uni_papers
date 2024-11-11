import 'dart:convert';
import 'package:flutter/material.dart';
import '/models/entities/research.dart';
import '/utils/colors.dart';
import '/widgets/util_functions.dart';

class SingleArticlePage extends StatelessWidget {
  const SingleArticlePage({super.key});

  static const routeName = '/single_article_page';

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Research;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Visualização de artigo",
          style: TextStyle(color: white),
        ),
        backgroundColor: blue,
        iconTheme: const IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
          child: Column(
            children: [
              // Título do artigo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  utf8.decode(article.title.codeUnits),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              //Autor e informações
              Container(
                margin: const EdgeInsets.fromLTRB(0, 70, 0, 70),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: const Text(
                        "Autor",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            utf8.decode(article.author.name.codeUnits),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Text(
                          "Email: ${article.author.email}",
                        ),
                        Text(
                          "Curso: ${utf8.decode(article.author.course.codeUnits)}",
                        ),
                        const Text(
                          "Universidade de Sorocaba - UNISO",
                        )
                      ],
                    )
                  ],
                ),
              ),
              // Descrição do artigo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const Text(
                      "Descrição",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        utf8.decode(article.description.codeUnits),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              //Botão de Download
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 70, 0, 70),
                child: ElevatedButton(
                  onPressed: () {
                    saveBLOBAsPDF(article.blobFile, article.title);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellow,
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      )),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: const Text(
                      "Baixar artigo em PDF",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
