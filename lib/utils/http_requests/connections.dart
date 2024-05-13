import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unipapers_collab_proj/model/entities/reader.dart';
import 'package:unipapers_collab_proj/model/entities/writer.dart';

Future<Reader> fetchReaderWithEmail(String email) async {
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/readers/email?email=$email'));

  if (response.statusCode == 200) {
    // Servidor respondeu OK, ou seja, deu bom :)
    return Reader.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Usuário não encontrado');
  }
}

Future<Writer> fetchWriterWithEmail(String email) async {
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/writers/email?email=$email'));

  if (response.statusCode == 200) {
    // Servidor respondeu OK, ou seja, deu bom :)
    return Writer.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Usuário não encontrado');
  }
}
