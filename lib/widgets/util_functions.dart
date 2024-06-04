import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/entities/reader.dart';
import '../models/entities/research.dart';
import '../models/entities/writer.dart';
import '../utils/http_requests/connections.dart';

import 'package:document_file_save_plus/document_file_save_plus.dart';

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

Future<String> convertPDFUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true, allowedExtensions: ["pdf"], type: FileType.custom);

  FilePickerStatus.done;
  if (result != null) {
    PlatformFile file = result.files.first;
    Uint8List? bytesList = file.bytes;
    String fileName = file.name;
    String decode = bytesList!.map((e) => e.toString()).join(",");

    String fileStr = "$fileName v4ta4watv4et5v435te435 $decode";

    return fileStr;
  } else {
    return "Erro";
  }
}

List<int> convertStringToBytes(String bytes) {
  // Remove quaisquer espaços em branco extras
  bytes = bytes.replaceAll(RegExp(r'\s+'), '') + ",";
  print(bytes);

  List<int> listBytes = [];

  while (bytes != "") {
    String caracteresAteProximaVirgula = bytes.substring(0, bytes.indexOf(","));
    print(caracteresAteProximaVirgula);
    listBytes.add(int.parse(caracteresAteProximaVirgula));

    bytes = bytes.replaceFirst(caracteresAteProximaVirgula, "");
    bytes = bytes.replaceFirst(bytes.substring(0, bytes.indexOf(",") + 1), "");
    print(bytes);
  }
  if (bytes == "") {
    print(listBytes);
    return listBytes;
  } else {
    return [];
  }
  // return [];
}

Future<void> saveBLOBAsPDF(String? bytes, String fileName) async {
  try {
    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();
      String newFileName = utf8.decode(fileName.replaceAll(" ", "_").codeUnits);
      final file = File("${directory.path}/$newFileName.pdf");

      // List<int> bytesList = convertStringToBytes(bytes!);
      // print('Lista de bytes: $bytesList');

      Uint8List data = Uint8List.fromList(convertStringToBytes(bytes!));

      DocumentFileSavePlus().saveFile(data, newFileName, "text.pdf");
      print("PDF salvo em ${directory.path}/$newFileName.pdf");
      OpenFile.open('${directory.path}/$newFileName.pdf');
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
