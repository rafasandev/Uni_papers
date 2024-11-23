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

// Future<String> convertPDFUpload() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     withData: true,
//     allowedExtensions: ["pdf"],
//     type: FileType.custom,
//   );

//   FilePickerStatus.done;
//   if (result != null) {
//     String fileName = result.files.first.name;
//     return fileName;
//   } else {
//     return "Erro";
//   }
// }

Future<Map<String, dynamic>> convertPDFUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    withData: true,
    allowedExtensions: ["pdf"],
    type: FileType.custom,
  );

  FilePickerStatus.done;
  if (result != null) {
    return {
      "fileName": result.files.single.name,
      "file": result.files.single.bytes
    };
  } else {
    return {"fileName": null, "file": null};
  }
}

Future<void> saveBLOBAsPDF(
    Uint8List? blobFile, String fileName, BuildContext context) async {
  try {
    if (blobFile == null) {
      alertError("Blob está vazio", context);
    }

    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();

      String newFileName = utf8.decode(fileName.replaceAll(" ", "_").codeUnits);
      final filePath = "${directory.path}/$newFileName.pdf";

      final file = File(filePath);
      await file.writeAsBytes(blobFile!);
      await DocumentFileSavePlus().saveFile(
        blobFile,
        fileName,
        "application/pdf",
      );
      await OpenFile.open(filePath);
      // Uint8List data = blobFile!;
      // print(data);
      // file.writeAsBytesSync(data);

      // DocumentFileSavePlus().saveFile(data, newFileName, "text.pdf");
      // print("PDF salvo em ${directory.path}/$newFileName.pdf");
      // OpenFile.open('${directory.path}/$newFileName.pdf');
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro ao abrir documento'),
        content: Text('$e'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop,
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
