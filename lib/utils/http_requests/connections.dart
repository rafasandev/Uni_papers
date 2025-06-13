import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:unipapers_project/utils/logic.dart';
import '/models/entities/reader.dart';
import '/models/entities/research.dart';
import '/models/entities/writer.dart';

/* Links Luiz - PC Trabalho, pessoal e geral */
const String apiLink = 'http://192.168.0.107:8080/api'; //Note

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
      hashSalt: '',
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
      hashSalt: '',
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

Future<void> updateReader(
  int id,
  String name,
  String phone,
  String email,
  String password,
  String hashSalt,
) async {
  final response = await http.put(
    Uri.parse('$apiLink/readers/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'hashSalt': hashSalt,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Falha ao atualizar usuário!');
  }
}

Future<void> updateWriter(
  int id,
  String name,
  String phone,
  String email,
  String password,
  String curso,
  String ra,
  String hashSalt,
) async {
  final response = await http.put(
    Uri.parse('$apiLink/writers/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'course': curso,
      'ra': ra,
      'hashSalt': hashSalt,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Falha ao atualizar usuário!');
  }
}

Future<Reader> createReader(
  String name,
  String phone,
  String email,
  String password,
) async {
  String salt = createSalt();
  String hashedPassword = hashPassword(password, salt);

  final response = await http.post(
    Uri.parse('$apiLink/readers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'phone': phone,
      'email': email,
      'password': hashedPassword,
      'hashSalt': salt,
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
  String name,
  String phone,
  String email,
  String password,
  String course,
  String ra,
) async {
  String salt = createSalt();
  String hashedPassword = hashPassword(password, salt);

  final response = await http.post(
    Uri.parse('$apiLink/writers'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'name': name,
        'phone': phone,
        'email': email,
        'password': hashedPassword,
        'course': course,
        'ra': ra,
        'hashSalt': salt,
      },
    ),
  );

  if (course == 'CURSO') {
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
