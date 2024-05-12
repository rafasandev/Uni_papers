import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isWriter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 80),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset('/assets/images/logo.png'),
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
                ),
                SizedBox(
                  height: 25,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'É um escritor?',
                //         style: TextStyle(fontSize: 15),
                //       ),
                //       Checkbox(
                //         value: isWriter,
                //         activeColor: yellow,
                //         checkColor: Colors.black,
                //         onChanged: (value) {
                //           setState(() {
                //             isWriter = value!;
                //           });
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
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
                              fontWeight: FontWeight.bold,
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
