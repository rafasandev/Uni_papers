import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/article.dart';
import 'package:unipapers_project/models/entities/research.dart';
import 'package:unipapers_project/utils/colors.dart';
import 'package:unipapers_project/widgets/util_functions.dart';

class ArticleCreationPage extends StatefulWidget {
  ArticleCreationPage({super.key});

  @override
  State<ArticleCreationPage> createState() => _ArticleCreationPageState();
}

class _ArticleCreationPageState extends State<ArticleCreationPage> {
  final _formKey = GlobalKey<FormState>();

  int countAuthors = 1;
  String title = '';
  Map<String, String> author = {};
  String description = '';
  String fileStr = '';
  String fileBytes = "";
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    int writerId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: const BoxDecoration(color: yellow),
              margin: EdgeInsets.only(bottom: 10),
              child: const Text(
                "Upload de Artigo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: const Text("Título do artigo*"),
                        hintText: "Ex: Desenvolvimento celular em maçâs",
                        filled: true,
                        fillColor: white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) =>
                          value == "" ? "Este campo deve ser preenchido" : null,
                      onChanged: (value) {
                        setState(() {
                          title = value;
                          print(title);
                        });
                      },
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        for (var i = 0; i < countAuthors; i++)
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text("Autor*"),
                                filled: true,
                                fillColor: white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              validator: (value) => value == ""
                                  ? "Este campo deve ser preenchido"
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  author[i.toString()] = value;
                                  print(author);
                                });
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              countAuthors++;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: background,
                            elevation: 0.0,
                          ),
                          child: const Text(
                            "Adicionar autor +",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      if (countAuthors > 1)
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                countAuthors--;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: background,
                              elevation: 0.0,
                            ),
                            child: const Text(
                              "Remover autor -",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            "Descrição*",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (value) => value == ""
                              ? "Este campo deve ser preenchido"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        List<String> fileInfo =
                            savePDFArchive() as List<String>;
                        for (var i = 0; i < fileInfo.length; i++) {
                          if (i == 0) {
                            setState(() {
                              fileName = fileInfo[i];
                            });
                          }
                          if (i == 1) {
                            setState(() {
                              fileBytes = fileInfo[i];
                            });
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: yellow,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Carregar arquivo PDF"),
                    ),
                  ),
                  if (fileName != "")
                    Container(
                      child: Text(
                        "Arquivo carregado: $fileName",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
