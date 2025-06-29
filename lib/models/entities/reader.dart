// ignore_for_file: unnecessary_getters_setters

class Reader {
  int _id;
  String _name;
  String _phone;
  String _email;
  String _password;
  String _hashSalt;

  Reader({
    required int id,
    required String name,
    required String phone,
    required String email,
    required String password,
    required String hashSalt,
  })  : _hashSalt = hashSalt,
        _password = password,
        _email = email,
        _phone = phone,
        _name = name,
        _id = id;

  factory Reader.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "name": String name,
        "phone": String phone,
        "email": String email,
        "password": String password,
        "hashSalt": String hashSalt,
      } =>
        Reader(
          id: id,
          name: name,
          phone: phone,
          email: email,
          password: password,
          hashSalt: hashSalt,
        ),
      _ => throw const FormatException('Failed to load reader.'),
    };
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get hashSalt => _hashSalt;

  set hashSalt(String value) {
    _hashSalt = value;
  }
}
