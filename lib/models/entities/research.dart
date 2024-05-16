import '/models/entities/writer.dart';

class Research {
  int _id;
  String _title;
  String _description;
  String _textFileName;
  Writer _author;

  Research({
    required int id,
    required String title,
    required String description,
    required String textFileName,
    required Writer author,
  })  : _author = author,
        _textFileName = textFileName,
        _description = description,
        _title = title,
        _id = id;

  factory Research.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String title,
        "description": String description,
        "textFileName": String textFileName,
        "writer":
            // Writer author,
            {
          "id": int idWriter,
          "name": String nameWriter,
          "phone": String phoneWriter,
          "email": String emailWriter,
          "password": String passwordWriter,
          "course": String courseWriter,
          "ra": String raWriter,
        }
      } =>
        Research(
          id: id,
          title: title,
          description: description,
          textFileName: textFileName,
          author: Writer(
            id: idWriter,
            name: nameWriter,
            phone: phoneWriter,
            email: emailWriter,
            password: passwordWriter,
            course: courseWriter,
            ra: raWriter,
          ),
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

  String get textFileName => _textFileName;

  set textFileName(String value) {
    _textFileName = value;
  }

  Writer get author => _author;

  set author(Writer value) {
    _author = value;
  }
}
