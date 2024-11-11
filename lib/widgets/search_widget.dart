import 'package:flutter/material.dart';

import 'article_widget.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: fetchResearchByName(search),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.all(screenHeight * 0.05),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Research>? researches = snapshot.data;
          if (snapshot.hasData) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ArticleWidget(
                        article: researches.reversed.toList()[index]);
                  },
                  itemCount: researches!.length,
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
    );
  }
}
