import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/colors.dart';

import '../widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String search = '';
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 00),
                      child: Image.asset("lib/images/onlyHandsLogo.png"),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                            label: const Text("Pesquise por um artigo"),
                            focusColor: blue,
                            suffixIcon: (search == "")
                                ? const Icon(Icons.search)
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        search = "";
                                        clearText();
                                        SearchWidget(search: search);
                                      });
                                    },
                                    icon: const Icon(Icons.close)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                        controller: fieldText,
                        onChanged: (value) {
                          setState(() {
                            search = value;
                            SearchWidget(
                              search: search,
                            );
                          });
                        },
                      ),
                    ),
                    if (search != '')
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                        child: Row(
                          children: [
                            const Text(
                              "Resultados para: ",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              search,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SearchWidget(search: search),
            ],
          ),
        ),
      ),
    );
  }
}
