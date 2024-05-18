import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unipapers_project/models/entities/research.dart';
import 'package:unipapers_project/widgets/util_functions.dart';

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
      body: Center(
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
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Research> researches = snapshot.data!;
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
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
    );
  }
}
