import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';
import '../models/entities/reader.dart';
import '../models/entities/writer.dart';
import '/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isWriter = false;
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 55),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset('lib/images/logo.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'ENTRAR NA SUA CONTA',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    labelText: 'Email',
                    hintText: 'Escreva seu melhor email aqui!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Este campo deve ser preenchido";
                    } else if (!value.contains("@")) {
                      return "Formato de email inválido";
                    }
                    return null;
                  },
                  onChanged: (value) => email = value.toLowerCase(),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null) {
                      return "Este campo deve ser preenchido";
                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Sua senha deve conter letras e números";
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'É um escritor?',
                        style: TextStyle(fontSize: 15),
                      ),
                      Checkbox(
                        value: isWriter,
                        activeColor: yellow,
                        checkColor: Colors.black,
                        onChanged: (value) {
                          setState(() {
                            isWriter = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (isWriter) {
                              _loginWriter(email, password, context);
                            } else {
                              _loginReader(email, password, context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          side: BorderSide(
                            width: 2.5,
                            color: Colors.black,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Não possui uma conta?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/cadastro_page");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _loginReader(String email, String password, BuildContext context) {
  late Reader user;

  fetchReaderWithEmail(email).then((reader) {
    user = reader;
    if (reader != null && reader.password == password) {
      Navigator.pushNamed(
        context,
        '/cadastro_page',
        arguments: user,
      );
    } else {
      alertError('Email ou senha inválidos', context);
    }
  }).catchError((error) {
    alertError(error, context);
  });
}

void _loginWriter(String email, String senha, BuildContext context) {
  late Writer user;

  fetchWriterWithEmail(email).then((writer) {
    user = writer;
    if (writer != null && writer.password == senha) {
      Navigator.pushNamed(
        context,
        '/cadastro_page',
        arguments: user,
      );
    } else {
      alertError('Email ou senha inválidos', context);
    }
  }).catchError((error) {
    alertError(error, context);
  });
}

Future<void> alertError(String algo, BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(algo),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('ok'),
          ),
        ],
      );
    },
  );
}
