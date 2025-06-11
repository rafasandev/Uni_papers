import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unipapers_project/models/entities/reader.dart';
import 'package:unipapers_project/models/entities/writer.dart';
import 'package:unipapers_project/utils/colors.dart';
import 'package:unipapers_project/utils/courses_list.dart';
import 'package:unipapers_project/widgets/update_reader_widget.dart';
import 'package:unipapers_project/widgets/update_writer_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool passVisible = false;
  @override
  Widget build(BuildContext context) {
    dynamic user = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Image.asset("lib/images/onlyHandsLogo.png"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "EDITAR PERFIL",
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        initialValue: user.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          labelText: "Nome Completo",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => user.name = value,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return "Este campo deve ser preenchido";
                          } else if (value.contains(RegExp(r'[0-9]'))) {
                            return "Insira um nome válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          TextInputMask(mask: '(99) 99999-9999'),
                        ],
                        initialValue: user.phone,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          labelText: "Telefone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => user.phone = value,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return "Este campo deve ser preenchido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: user.email,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => user.email = value,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return "Este campo deve ser preenchido";
                          }
                          if (!value.contains("@")) {
                            return "Insira um email válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: user.password,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          labelText: "Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: (passVisible)
                              ? IconButton(
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                  onPressed: () {
                                    setState(() {
                                      passVisible = !passVisible;
                                    });
                                  })
                              : IconButton(
                                  icon:
                                      const Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    setState(() {
                                      passVisible = !passVisible;
                                    });
                                  }),
                        ),
                        obscureText: !passVisible,
                        onChanged: (value) => user.password = value,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return "Este campo deve ser preenchido";
                          }
                          if (value.length < 8) {
                            return "Sua senha deve conter pelo menos 8 caracteres";
                          }
                          if (!value.contains(RegExp(r'[0-9]')) ||
                              !value.contains(RegExp(r'[a-z]'))) {
                            return "Sua senha deve conter letras e números";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          labelText: "Confirme a Nova Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (user.password != value) {
                            return "As senhas não conferem";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Builder(builder: (context) {
                        if (user is Writer) {
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  label: Text('Curso'),
                                  filled: true,
                                  fillColor: white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                isExpanded: true,
                                value: user.course,
                                hint: Text(user.course),
                                dropdownColor: white,
                                items: coursesList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    user.course = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == 'CURSO' ||
                                      value == null ||
                                      value == '') {
                                    return 'Este campo precisa ser preenchido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                initialValue: user.ra,
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 8,
                                buildCounter: removeLimitShow,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: white,
                                  labelText: "RA",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) => value,
                                validator: (value) {
                                  if (value == '' || value == null) {
                                    return "Este campo deve ser preenchido";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text.rich(
                                TextSpan(
                                  text:
                                      'Para realizar alterações em seu RA, contate o suporte via e-mail: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'suporte@unipapers.com.br',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }
                        return SizedBox();
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState!.validate()) {
                                    if (user is Reader) {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return UpdateReaderWidget(
                                              id: user.id,
                                              name: user.name,
                                              phone: user.phone,
                                              email: user.email,
                                              password: user.password,
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return UpdateWriterWidget(
                                              id: user.id,
                                              name: user.name,
                                              phone: user.phone,
                                              email: user.email,
                                              password: user.password,
                                              course: user.course,
                                              ra: user.ra,
                                            );
                                          });
                                    }
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blue,
                                side: const BorderSide(
                                  width: 2.5,
                                  color: Colors.black,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Atualizar',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget? removeLimitShow(
    _, {
    required currentLength,
    required isFocused,
    maxLength,
  }) =>
      null;
}
