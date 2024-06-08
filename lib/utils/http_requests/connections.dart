import 'dart:convert';

import 'package:http/http.dart' as http;
import '/models/entities/reader.dart';
import '/models/entities/research.dart';
import '/models/entities/writer.dart';

Future<Reader> fetchReaderWithEmail(String email) async {
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/readers/email?email=$email'));

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
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/writers/email?email=$email'));

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
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/researches'));

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
  final response = await http.get(Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/researches/name?name=$name'));

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

  if (response.statusCode == 201) {
    return Writer.fromJson(json.decode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao criar escritor');
  }
}

Future<Research> createResearch(
  final String title,
  final String authorName,
  final String description,
  final String fileBase64,
  final String authorId,
) async {
  print(fileBase64);
  Map<String, dynamic> body = {
    "name": title,
    "description": description,
    "blobFile": fileBase64,
    "writer": {"id": authorId},
    "collaborators": authorName,
  };
  print(jsonEncode(body));
  final response = await http.post(
    Uri.parse(
      'https://unipapers-requests-5d1ab2edc5c0.herokuapp.com/api/researches',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    print("Artigo criado com sucesso");
    return Research.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    throw Exception("Falha ao criar artigo");
  }
}
