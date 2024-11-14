import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unipapers_project/models/entities/writer.dart';
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
  Uint8List? file;
  Research? response;
  bool researchCreated = false;

  @override
  Widget build(BuildContext context) {
    Writer writer = ModalRoute.of(context)!.settings.arguments as Writer;
    return Scaffold(
      backgroundColor: background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: yellow,
          flexibleSpace: const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Upload de Artigo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: !researchCreated
              ? Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: const Text("Título do artigo*"),
                                hintText:
                                    "Ex: Desenvolvimento celular em maçãs",
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
                          Column(
                            children: [
                              for (var i = 0; i < countAuthors; i++)
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 10),
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
                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 0, 10),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      countAuthors++;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // backgroundColor: background,
                                    // elevation: 0.0,
                                    backgroundColor: blue,
                                    side: const BorderSide(
                                      width: 1.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: const Text(
                                    "Adicionar autor +",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              if (countAuthors > 1)
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 20, 10),
                                  alignment: Alignment.centerRight,
                                  // TODO: ARRUMAR ESSA BOSTA DE BOTÃO
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        countAuthors--;

                                        author.remove(countAuthors.toString());
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // backgroundColor: background,
                                      // elevation: 0.0,
                                      backgroundColor: const Color.fromARGB(
                                          255, 202, 59, 49),
                                      side: const BorderSide(
                                        width: 1.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: const Text(
                                      "Remover autor -",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                              padding:
                                  const EdgeInsets.fromLTRB(40, 20, 40, 20),
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

                                  newConvertPDFUpload()
                                      .then((value) => file = value);
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                                  // response = await createResearch(
                                  //   title,
                                  //   collaborators,
                                  //   description,
                                  //   fileBase64,
                                  //   writerId.toString(),
                                  // );
                                  response = await newCreateResearch(
                                    title: title,
                                    collab: collaborators,
                                    description: description,
                                    fileBase64: file,
                                    writer: writer,
                                  );
                                }
                                setState(() {
                                  if (response != null) {
                                    researchCreated = true;
                                    Timer(
                                        const Duration(seconds: 4),
                                        () => Navigator.pushNamed(
                                              context,
                                              "/main_page",
                                              arguments: writer,
                                            ));
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: const Text(
                                      "Confirmar",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                  const Icon(
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
              : const Center(
                  child: Text(
                    "Artigo Criado com sucesso",
                    style: TextStyle(
                        fontSize: 20, color: blue, fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ),
    );
  }
}
