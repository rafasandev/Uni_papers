import 'package:flutter/material.dart';

Future main() async {
  runApp(const MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final myControllerEmail = TextEditingController();
  final myControllerPass = TextEditingController();
  final myControllerPassConfirmation = TextEditingController();
  final myControllerName = TextEditingController();
  final myControllerDate = TextEditingController();

  @override
  void dispose() {
    myControllerEmail.dispose();
    myControllerName.dispose();
    myControllerDate.dispose();
    myControllerPass.dispose();
    myControllerPassConfirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign up Page'),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                    controller: myControllerEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    controller: myControllerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Birth Date cannot be empty';
                      }
                      return null;
                    },
                    controller: myControllerDate,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'dd/mm/aaaa',
                      labelText: 'Birth Date',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: myControllerPass,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value != myControllerPass.text) {
                        return 'Passwords does not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: myControllerPassConfirmation,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
