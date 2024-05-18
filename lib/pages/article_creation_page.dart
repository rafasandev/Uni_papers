import 'package:flutter/material.dart';

class ArticleCreationPage extends StatefulWidget {
  const ArticleCreationPage({super.key});

  @override
  State<ArticleCreationPage> createState() => _ArticleCreationPageState();
}

class _ArticleCreationPageState extends State<ArticleCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Artigo"),
      ),
    );
  }
}
