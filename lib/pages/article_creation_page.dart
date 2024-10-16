import 'dart:async';

import 'package:flutter/material.dart';
import '/models/entities/research.dart';
import '/utils/colors.dart';
import '/utils/http_requests/connections.dart';
import '/widgets/util_functions.dart';

class ArticleCreationPage extends StatefulWidget {
  const ArticleCreationPage({super.key});

  @override
  State<ArticleCreationPage> createState() => _ArticleCreationPageState();
}

class _ArticleCreationPageState extends State<ArticleCreationPage> {
  final _formKey = GlobalKey<FormState>();

  int countAuthors = 1;
  String title = '';
  Map<String, String> author = {};
  String description = '';
  String fileBase64 = "";
  String fileName = "";

  Research? response;
  bool researchCreated = false;

  @override
  Widget build(BuildContext context) {
    int writerId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
      ),
      body: SingleChildScrollView(
        child: !researchCreated
            ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: const BoxDecoration(color: yellow),
                    margin: const EdgeInsets.only(bottom: 10),
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
                              hintText: "Ex: Desenvolvimento celular em maçãs",
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
                                title = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              for (var i = 0; i < countAuthors; i++)
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      label: const Text("Autor*"),
                                      filled: true,
                                      fillColor: white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    validator: (value) => value == ""
                                        ? "Este campo deve ser preenchido"
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        author[i.toString()] = value;
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
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      countAuthors--;

                                      author.remove(countAuthors.toString());
                                      print(author);
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
                              const Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  "Descrição*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
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
                        if (fileName != "")
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            child: Text(
                              "Arquivo carregado: $fileName",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: ElevatedButton(
                            onPressed: () {
                              List<String> valuesFile;
                              convertPDFUpload().then((value) {
                                valuesFile =
                                    value.split(" v4ta4watv4et5v435te435 ");
                                setState(() {
                                  fileName = valuesFile[0];
                                  fileBase64 = valuesFile[1];
                                });
                              });
                            },
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: yellow,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text("Carregar arquivo PDF"),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: ElevatedButton(
                            onPressed: () async {
                              _formKey.currentState!.validate();
                              String collaborators = "";
                              for (var authorName in author.values) {
                                collaborators += "$authorName---";
                              }
                              if (fileBase64 != "" &&
                                  fileName != "" &&
                                  collaborators != "") {
                                response = await createResearch(
                                  title,
                                  collaborators,
                                  description,
                                  fileBase64,
                                  writerId.toString(),
                                );
                              }
                              setState(() {
                                if (response != null) {
                                  researchCreated = true;
                                  Timer(
                                      Duration(seconds: 4),
                                      () => Navigator.pushNamed(
                                          context, "/main_page"));
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              elevation: 0,
                              foregroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    "Confirmar",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: background,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.check,
                                  color: background,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  "Artigo Criado com sucesso",
                  style: TextStyle(
                      fontSize: 20, color: blue, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
