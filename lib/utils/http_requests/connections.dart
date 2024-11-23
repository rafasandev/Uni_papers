import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '/models/entities/reader.dart';
import '/models/entities/research.dart';
import '/models/entities/writer.dart';

/* Links Luiz - PC Trabalho, pessoal e geral */
// const String apiLink = 'http://pc-luiz:8080/api'; // Trabalho
// const String apiLink = 'http://luizpc:8080/api'; //Note
// const String apiLink = 'http://localhost:8080/api'; // Local
const String apiLink = 'http://192.168.0.110:8080/api';

Future<Reader> fetchReaderWithEmail(String email) async {
  final response =
      await http.get(Uri.parse('$apiLink/readers/email?email=$email'));

  if (response.statusCode == 200) {
    // Servidor respondeu OK, ou seja, deu bom :)
    return Reader.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    Reader reader = Reader(
      id: 0,
      name: 'ERRO',
      phone: '',
      email: '',
      password: 'ERRO',
    );
    return reader;
  }
}

Future<Writer> fetchWriterWithEmail(String email) async {
  final response =
      await http.get(Uri.parse('$apiLink/writers/email?email=$email'));

  if (response.statusCode == 200) {
    // Servidor respondeu OK, ou seja, deu bom :)
    return Writer.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    Writer writer = Writer(
      id: 0,
      name: 'ERRO',
      phone: '',
      email: '',
      password: 'ERRO',
      course: '',
      ra: '',
    );
    return writer;
  }
}

Future<List<Research>> fetchAllResearches() async {
  final response = await http.get(Uri.parse('$apiLink/researches'));

  if (response.statusCode == 200) {
    // Servidor retornou as pesquisas
    Iterable list = json.decode(response.body);
    List<Research> researches =
        List<Research>.from(list.map((e) => Research.fromJson(e)));
    return researches;
  } else {
    throw Exception('Falha ao recuperar pesquisas');
  }
}

Future<List<Research>> fetchResearchByName(String name) async {
  final response =
      await http.get(Uri.parse('$apiLink/researches/name?name=$name'));

  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    List<Research> researches =
        List<Research>.from(list.map((e) => Research.fromJson(e)));
    return researches;
  } else {
    throw Exception('Falha ao pesquisar artigos');
  }
}

Future<Reader> createReader(
  String nome,
  String telefone,
  String email,
  String senha,
) async {
  final response = await http.post(
    Uri.parse('$apiLink/readers'),
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

Future<Writer> createWriter(
  String nome,
  String telefone,
  String email,
  String senha,
  String curso,
  String ra,
) async {
  final response = await http.post(
    Uri.parse('$apiLink/writers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'name': nome,
        'phone': telefone,
        'email': email,
        'password': senha,
        'course': curso,
        'ra': ra,
      },
    ),
  );

  if (curso == 'CURSO') {
    throw Exception('Curso deve ser escolhido');
  } else if (response.statusCode == 201) {
    return Writer.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao criar escritor');
  }
}

Future<Research> createResearch({
  required String title,
  required String collab,
  required String description,
  required Uint8List? blobFile,
  required Writer writer,
}) async {
  final response = await http.post(
    Uri.parse(
      '$apiLink/researches',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, dynamic>{
        "name": title,
        "description": description,
        "collaborators": collab,
        "writer": {"id": writer.id.toString()},
        "blobFile": base64.encode(blobFile!),
      },
    ),
  );
  if (response.statusCode == 201) {
    return Research.fromJson(
        json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Erro ao criar pesquisa');
  }
}
