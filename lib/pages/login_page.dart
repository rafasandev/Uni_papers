import 'package:flutter/material.dart';
import '../widgets/util_functions.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 55),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset('lib/images/logo.png'),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'ENTRAR NA SUA CONTA',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    labelText: 'Email',
                    hintText: 'exemplo@email.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == '') {
                      return "Este campo deve ser preenchido";
                    }
                    if (!value!.contains("@")) {
                      return "Formato de email inválido";
                    }
                    return null;
                  },
                  onChanged: (value) => email = value.toLowerCase(),
                ),
                const SizedBox(
                  height: 15,
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
                    if (value == '') {
                      return "Este campo deve ser preenchido";
                    }
                    if (!value!.contains(RegExp(r'[0-9]'))) {
                      return "Sua senha deve conter letras e números";
                    }
                    if (value.length < 6) {
                      return "Sua senha deve ter pelo menos 8 caracteres";
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
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
                              loginWriter(email, password, context);
                            } else {
                              loginReader(email, password, context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          side: const BorderSide(
                            width: 2.5,
                            color: Colors.black,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
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
                      child: const Text(
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
