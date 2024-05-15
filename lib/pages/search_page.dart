// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/article.dart';

import '../models/components/article_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
          ],
        ),
      ),
    );
  }
}
