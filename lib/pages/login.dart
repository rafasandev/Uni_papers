import 'package:flutter/material.dart';
import 'package:unipapers_project/pages/signup.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final myController = TextEditingController();
  final myControllerPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    myController.dispose();
    myControllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainWidget(
        formKey: _formKey,
        myControllerEmail: myController,
        myControllerPass: myControllerPass);
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.myControllerEmail,
    required this.myControllerPass,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController myControllerEmail;
  final TextEditingController myControllerPass;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login page'),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Login cannot be empty';
                      }
                      return null;
                    },
                    controller: myControllerEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Login',
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
