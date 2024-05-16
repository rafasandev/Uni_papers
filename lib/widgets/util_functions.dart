import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/entities/reader.dart';
import '../models/entities/writer.dart';
import '../utils/http_requests/connections.dart';

Future<void> alertError(String text, BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

void loginReader(String email, String password, BuildContext context) {
  late Reader user;
  try {
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
      alertError('Email inválido', context);
    });
  } catch (e) {
    alertError('Usuário não encontrado', context);
  }
}

void loginWriter(String email, String senha, BuildContext context) {
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

void getFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    print(file);
  } else {
    print("Erro");
  }
}
