import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/colors.dart';
import '/models/entities/research.dart';

import '../widgets/article_widget.dart';
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
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Research>>(
            future: fetchAllResearches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.stackTrace}'));
              } else {
                List<Research> researches = snapshot.data!;
                researches = researches.reversed.toList();

                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 20, 80, 20),
                        child: Image.asset("lib/images/onlyHandsLogo.png"),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: ListView.builder(
                            itemCount: researches.length,
                            itemBuilder: (context, index) {
                              return ArticleWidget(article: researches[index]);
                            },
                          ),
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
      ),
    );
  }
}
