import 'package:flutter/material.dart';

class SignUpWriterWidget extends StatefulWidget {
  const SignUpWriterWidget({
    super.key,
    required this.name,
    required this.telefone,
    required this.email,
    required this.senha,
    required this.dropdownValue,
    required this.ra,
  });

//         nome, telefone, email, senha, dropdownValue, ra);
  final String name;
  final String telefone;
  final String email;
  final String senha;
  final String dropdownValue;
  final String ra;

  @override
  State<SignUpWriterWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWriterWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
