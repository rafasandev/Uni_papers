import 'package:flutter/material.dart';

import '../models/components/article_widget.dart';
import '../models/entities/research.dart';
import '../utils/http_requests/connections.dart';

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
