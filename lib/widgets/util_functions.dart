import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    withData: true,
    allowedExtensions: ["pdf"],
    type: FileType.custom,
  );

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

Future<Uint8List?> newConvertPDFUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    withData: true,
    allowedExtensions: ["pdf"],
    type: FileType.custom,
  );

  FilePickerStatus.done;
  if (result != null) {
    final bytes = await result.files.single.bytes;
    return bytes;
  } else {
    return null;
  }
}

Future<Uint8List> decodeBase64ToList(String base64Str) async {
  return await Future.microtask(() => (base64Decode(base64Str)));
}

Future<void> saveBLOBAsPDF(Uint8List? base64Str, String fileName) async {
  try {
    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();
      String newFileName = utf8.decode(fileName.replaceAll(" ", "_").codeUnits);
      final file = File("${directory.path}/$newFileName.pdf");

      print(base64Str);
      Uint8List data = base64Str!;
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
