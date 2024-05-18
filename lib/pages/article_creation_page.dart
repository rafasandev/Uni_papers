import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/colors.dart';

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
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(127, 2, 14, 7),
                child: const Icon(
                  Icons.done,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Título do artigo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                      30,
                    ))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Data de publicação",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Nome do autor",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  30,
                )),
              ),
            ),
          ),
          Container(
            alignment: Alignment(-0.9, 1.2),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Adicionar autor +",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(10)),
              constraints:
                  BoxConstraints.tightForFinite(width: 300, height: 150),
              child: const Text(""),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
                constraints:
                    BoxConstraints.tightForFinite(width: 470, height: 55),
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 30),
                    backgroundColor: yellow,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text("Carregar arquivo PDF"),
                )),
          ),
        ],
      ),
    );
  }
}
