// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:flutter/services.dart';

import '/models/entities/writer.dart';

class Research {
  int _id;
  String _title;
  String _description;
  Uint8List? _blobFile;
  Writer _author;
  String? _collaborators = '';

  Research({
    required int id,
    required String title,
    required String description,
    required Uint8List? blobFile,
    required Writer author,
    required String? collaborators,
  })  : _author = author,
        _blobFile = blobFile,
        _description = description,
        _title = title,
        _id = id,
        _collaborators = collaborators;

  factory Research.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String title,
        "description": String description,
        "blobFile": String base64BlobFile,
        "writer": {
          // Writer author,
          "id": int idWriter,
          "name": String nameWriter,
          "phone": String phoneWriter,
          "email": String emailWriter,
          "password": String passwordWriter,
          "course": String courseWriter,
          "ra": String raWriter,
          "hashSalt": String hashSaltWriter,
        },
        "collaborators": String? collaborators,
      } =>
        Research(
          id: id,
          title: title,
          description: description,
          blobFile: base64Decode(base64BlobFile),
          author: Writer(
            id: idWriter,
            name: nameWriter,
            phone: phoneWriter,
            email: emailWriter,
            password: passwordWriter,
            course: courseWriter,
            ra: raWriter,
            hashSalt: hashSaltWriter,
          ),
          collaborators: collaborators,
        ),
      _ => throw const FormatException('Failed to load research.'),
    };
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  Uint8List? get blobFile => _blobFile;

  set blobFile(Uint8List? value) {
    _blobFile = value;
  }

  Writer get author => _author;

  set author(Writer value) {
    _author = value;
  }

  String? get collaborators => _collaborators;

  set collaborators(String? value) {
    _collaborators = value;
  }
}
