import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/article.dart';
import 'package:unipapers_project/models/entities/research.dart';
import 'package:unipapers_project/widgets/util_functions.dart';

import '../models/components/article_widget.dart';
import '../utils/http_requests/connections.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<Research>>(
          future: fetchAllResearches(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ]),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Research>? researches = snapshot.data;
              if (researches != null) {
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
                  child: Text('Sem pesquisas disponíveis'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

// Column(
//           children: [
//             Container(
//               padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
//               child: Image.asset("lib/images/onlyHandsLogo.png"),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//               child: Column(
//                 children: [
//                   //TODO: ListView.builder
//                   for (var i = 0; i < articles!.length; i++)
//                     ArticleWidget(article: articles![i])
//                 ],
//               ),
//             ),
//           ],
//         ),
