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
    return Center(
      child: FutureBuilder(
        future: fetchResearchByName(search),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(150.0),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Research>? researches = snapshot.data;
            if (researches != null && researches != []) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ArticleWidget(article: researches[index]);
                    },
                    itemCount: researches.length,
                  ),
                ),
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
