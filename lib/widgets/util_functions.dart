import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/entities/reader.dart';
import '../models/entities/research.dart';
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
          '/main_page',
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
  try {
    fetchWriterWithEmail(email).then((writer) {
      user = writer;
      if (writer != null && writer.password == senha) {
        Navigator.pushNamed(
          context,
          '/main_page',
          arguments: user,
          //TODO: Trocar isso por um Provider
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

void filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;
    Uint8List? bytesList = file.bytes;
    String fileName = file.name;

    saveBLOBasPDF(bytesList, fileName);
  } else {
    // User canceled the picker
  }
}

Future<void> saveBLOBasPDF(Uint8List? bytes, String fileName) async {
  try {
    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName';

      final file = File(filePath);
      await file.writeAsBytes(bytes!);

      print("PDF salvo em: $filePath");
    }
  } catch (e) {
    print(e);
  }
}

// List<Research> getResearches() {
//   late List<Research> researches;
//   try {
//     fetchAllResearches().then((value) {
//       Iterable list = json.decode(value);
//       researches = List<Research>.from(list.map((e) => Research.fromJson(e)));
//       if (researches != null) {
//         return researches;
//       } else {
//         throw Exception('List returned null');
//       }
//     });
//   } catch (e) {
//     print(e);
//   }
// }

// List<Research> getResearches() {
//   List<Research> list = [];
//   try {
//     fetchAllResearches().then((research) {
//       list.addAll(research);
//       return list;
//     }).catchError((error) {
//       print(error);
//       return [];
//     });
//   } catch (e) {
//     print(e);
//     return [];
//   }
// }
