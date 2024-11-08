import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/entities/reader.dart';
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
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}

Future<String> convertPDFUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true, allowedExtensions: ["pdf"], type: FileType.custom);

  FilePickerStatus.done;
  if (result != null) {
    PlatformFile file = result.files.first;
    Uint8List bytesList = file.bytes!;

    String base64Str = base64Encode(bytesList);

    print("String de base 64: $base64Str");

    String fileName = file.name;
    // String decode = bytesList.map((e) => e.toString()).join(",");

    String fileStr = "$fileName v4ta4watv4et5v435te435 $base64Str";

    return fileStr;
  } else {
    return "Erro";
  }
}

Future<Uint8List> decodeBase64ToList(String base64Str) async {
  return await Future.microtask(() => (base64Decode(base64Str)));
}

Future<void> saveBLOBAsPDF(String? base64Str, String fileName) async {
  try {
    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();
      String newFileName = utf8.decode(fileName.replaceAll(" ", "_").codeUnits);
      final file = File("${directory.path}/$newFileName.pdf");

      print(base64Str);
      Uint8List data = await decodeBase64ToList(base64Str!);
      print(data);

      file.writeAsBytesSync(data);

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
