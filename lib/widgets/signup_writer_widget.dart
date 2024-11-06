import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

class SignUpWriterWidget extends StatelessWidget {
  const SignUpWriterWidget({
    super.key,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.senha,
    required this.dropdownValue,
    required this.ra,
  });

  final String nome;
  final String telefone;
  final String email;
  final String senha;
  final String dropdownValue;
  final String ra;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: createWriter(
          nome,
          telefone,
          email,
          senha,
          dropdownValue,
          ra,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(150.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
            // return const SizedBox();
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Erro ao cadastrar usuário'),
              content: Text('${snapshot.error}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Text('Bem vindo ${nome.split(" ")[0]}'),
              content: const Text('Faça seu login na página inicial'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).popUntil((route) {
                    return route.settings.name == '/';
                  }),
                  child: const Text('Ok'),
                ),
              ],
            );
          }
        });
  }
}
