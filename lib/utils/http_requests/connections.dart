import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unipapers_project/models/entities/reader.dart';
import 'package:unipapers_project/models/entities/writer.dart';

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

Future<Reader> createReader(
    String nome, String telefone, String email, String senha) async {
  final response = await http.post(
    Uri.parse(
        'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/readers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': nome,
      'phone': telefone,
      'email': email,
      'password': senha,
    }),
  );

  if (response.statusCode == 201) {
    //Retornou o usuário criado com sucesso
    return Reader.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao criar leitor');
  }
}

Future<Writer> createWriter(String nome, String telefone, String email,
    String senha, String curso, ra) async {
  final response = await http.post(
    Uri.parse(
        'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/writers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': nome,
      'phone': telefone,
      'email': email,
      'password': senha,
      'course': curso,
      'ra': ra,
    }),
  );

  if (response.statusCode == 201) {
    return Writer.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao criar escritor');
  }
}
