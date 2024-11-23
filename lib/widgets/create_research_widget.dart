import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unipapers_project/utils/http_requests/connections.dart';

import '../models/entities/writer.dart';

class CreateResearchWidget extends StatelessWidget {
  const CreateResearchWidget({
    super.key,
    required this.title,
    required this.collaborators,
    required this.description,
    required this.blobFile,
    required this.writer,
  });

  final String title;
  final String collaborators;
  final String description;
  final Uint8List? blobFile;
  final Writer writer;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: createResearch(
          title: title,
          collab: collaborators,
          description: description,
          blobFile: blobFile,
          writer: writer,
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
              title: const Text('Erro ao postar pesquisa'),
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
              title: const Text('Pesquisa postada com sucesso!'),
              content: const Text(
                  'Retorne para a página principal e veja sua conquista'),
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
