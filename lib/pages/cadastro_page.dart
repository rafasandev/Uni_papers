import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unipapers_project/utils/colors.dart';
import 'package:unipapers_project/utils/courses_list.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = courses_list.first;
  int userSelected = 0;
  String nome = '';
  String telefone = '';
  String email = '';
  String senha = '';
  String ra = '';
  bool passVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset("lib/images/handsAndNameLogo.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "CRIAR CONTA",
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      labelText: "Nome Completo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => nome = value,
                    validator: (value) {
                      if (value == '') {
                        return "Este campo deve ser preenchido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 11,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      labelText: "Telefone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => telefone = value,
                    validator: (value) {
                      if (value == '') {
                        return "Este campo deve ser preenchido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value == '') {
                        return "Este campo deve ser preenchido";
                      }
                      if (!value!.contains("@")) {
                        return "Insira um email válido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      labelText: "Senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: (passVisible)
                          ? IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined),
                              onPressed: () {
                                setState(() {
                                  passVisible = !passVisible;
                                });
                              })
                          : IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  passVisible = !passVisible;
                                });
                              }),
                    ),
                    obscureText: !passVisible,
                    onChanged: (value) => senha = value,
                    validator: (value) {
                      if (value == '') {
                        return "Este campo deve ser preenchido";
                      }
                      if (value!.length < 6) {
                        return "Sua senha deve conter pelo menos 8 caracteres";
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return "Sua senha deve conter letras e números";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      labelText: "Confirme a Senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (senha != value) {
                        return "As senhas não conferem";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                            color: white),
                        child: const Text(
                          "Escolha se você é:",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: userSelected,
                            onChanged: (int? value) {
                              setState(() {
                                userSelected = value!;
                              });
                            },
                          ),
                          const Text(
                            "Leitor",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: userSelected,
                            onChanged: (int? value) {
                              setState(() {
                                userSelected = value!;
                              });
                            },
                          ),
                          const Text(
                            "Escritor",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    if (userSelected == 1) {
                      return Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 8,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: white,
                              labelText: "RA",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) => ra = value,
                            validator: (value) {
                              if (value == '' && userSelected == 1) {
                                return "Este campo deve ser preenchido";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropdownValue,
                              hint: const Text("CURSO"),
                              dropdownColor: white,
                              items: courses_list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                      onPressed: () async {
                        _formKey.currentState!.validate();
                        if (userSelected == 1) {
                          await createWriter(
                              nome, telefone, email, senha, dropdownValue, ra);
                        } else {
                          await createReader(nome, telefone, email, senha);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Criar Conta",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Já possuo conta',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
