import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                child: Image.asset("lib/images/onlyHandsLogo.png"),
              ),
              TextField(
                decoration: InputDecoration(
                    label: Text("Pesquise por um artigo"),
                    suffixIcon: (search == "")
                        ? Icon(Icons.search)
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                search = "";
                                clearText();
                                SearchWidget(search: search);
                              });
                            },
                            icon: Icon(Icons.close)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey))),
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
              if (search != '')
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                  child: Row(
                    children: [
                      Text(
                        "Resultados para: ",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        search,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              //TODO: IMPLEMENTAÇÃO DE PESQUISA
              SearchWidget(search: search)
            ],
          ),
        ),
      ),
    );
  }
}
