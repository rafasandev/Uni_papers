import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unipapers_project/models/entities/article.dart';
import 'package:unipapers_project/utils/colors.dart';

class ArticleWidget extends StatefulWidget {
  final Article article;

  const ArticleWidget({super.key, required this.article});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Column(
        children: [
          Text(
            widget.article.title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                for (var i = 0; i < widget.article.authorsName.length; i++)
                  Text(
                    widget.article.authorsName[i],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Acessar",
                  style: TextStyle(
                    color: white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellow,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
