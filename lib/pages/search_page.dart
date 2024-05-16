// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/article.dart';
import 'package:unipapers_project/models/entities/research.dart';
import 'package:unipapers_project/utils/colors.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

import '../models/components/article_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = '';

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
                    onChanged: (value) {
                      setState(() {
                        search = value;
                        SearchWidget(
                          search: search,
                        );
                      });
                    },
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
                          search,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO: IMPLEMENTAÇÃO DE PESQUISA
                  SearchWidget(search: search),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.search,
  });

  final String search;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: fetchResearchByName(search),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Research>? researches = snapshot.data;
            if (researches != null && researches != []) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                    child: Image.asset("lib/images/onlyHandsLogo.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Column(
                      children: [
                        //TODO: ListView.builder
                        for (var i = 0; i < researches.length; i++)
                          ArticleWidget(article: researches[i])
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Sem pesquisas com esse nome disponivel'),
              );
            }
          }
        }),
      ),
    );
  }
}


// for (int i = 0; i < articles.length; i++)
//                     ArticleWidget(
//                       article: articles[i],
//                     )