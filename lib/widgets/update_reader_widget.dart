import 'package:flutter/material.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

class UpdateReaderWidget extends StatelessWidget {
  const UpdateReaderWidget({
    super.key,
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.hashSalt,
  });

  final int id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String hashSalt;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: updateReader(
          id,
          name,
          phone,
          email,
          password,
          hashSalt,
        ),
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
              title: const Text('Erro ao atualizar usuário'),
              content: Text('${snapshot.error}'),
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
          } else {
            return AlertDialog(
              title: Text('Usuário atualizado com sucesso'),
              // content: const Text(''),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).popUntil((route) {
                    return route.settings.name == '/main_page';
                  }),
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          }
        });
  }
}
