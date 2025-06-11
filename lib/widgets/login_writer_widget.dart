import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/writer.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

class LoginWriterWidget extends StatelessWidget {
  const LoginWriterWidget({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchWriterWithEmail(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(150.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Erro ao logar usuário'),
              content: Text('An error occurred: ${snapshot.error}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
            );
          } else {
            Writer user = Writer(
              id: snapshot.data!.id,
              name: snapshot.data!.name,
              phone: snapshot.data!.phone,
              email: snapshot.data!.email,
              password: snapshot.data!.password,
              course: snapshot.data!.course,
              ra: snapshot.data!.ra,
            );

            if (user.password == 'ERRO' && user.name == 'ERRO') {
              return AlertDialog(
                title: const Text('Email ou senha inválidos'),
                content: const Text(
                  'Usuário não encontrado',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            } else if (user.password == password) {
              return AlertDialog(
                title:
                    Text('Bem vindo(a) ${snapshot.data!.name.split(" ")[0]}'),
                content: const Text(
                    'Seu login foi feito com sucesso, lhe desejamos bons estudos'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        '/main_page',
                        arguments: user,
                      );
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            } else {
              return AlertDialog(
                title: const Text('Senha inválida'),
                content: const Text(
                  'Tente novamente',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            }
          }
        });
  }
}
