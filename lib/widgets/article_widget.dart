import 'dart:convert';

import 'package:flutter/material.dart';
import '/models/entities/research.dart';
import '/utils/colors.dart';
import '/widgets/util_functions.dart';

class ArticleWidget extends StatefulWidget {
  final Research article;

  const ArticleWidget({super.key, required this.article});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    Future<void> handleSave() async {
      setState(() => isLoading = true);
      try {
        await saveBLOBAsPDF(
            widget.article.blobFile, widget.article.title, context);
      } finally {
        setState(() => isLoading = false);
      }
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/single_article_page',
              arguments: widget.article);
        },
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                utf8.decode(widget.article.title.codeUnits),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      utf8.decode(widget.article.description.codeUnits),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/single_article_page',
                        arguments: widget.article);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  ),
                  child: const Text(
                    "Acessar",
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : const Text(
                          "Download",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
