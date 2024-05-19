import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unipapers_project/models/entities/writer.dart';
import 'package:unipapers_project/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  final user;
  const ProfilePage({super.key, this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: background,
        ),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: const Text(
                  "Perfil",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: yellow, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Olá"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.waving_hand_outlined,
                        )
                      ],
                    ),
                    Text(
                      utf8.decode(widget.user.name.codeUnits),
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )
                  ],
                ),
                // child: Text("Edite seu perfil: ${widget.user!.name}"),
              ),
              Row(
                mainAxisAlignment: (widget.user is Writer)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      elevation: 0.0,
                      backgroundColor: background,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_profile");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(Icons.edit),
                          Text(
                            "Editar \n Perfil",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.user is Writer)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0.0,
                        backgroundColor: background,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/create_article",
                            arguments: widget.user.id);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.library_add_outlined),
                            Text(
                              "Carregar \n Artigo",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          "Sobre o UniPapers",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: const Text(
                            "O projeto UniPapers foi idealizado por alunos do curso de Engenharia da Computação da Universidade de Sorocaba (UNISO) com o propósito de integrar os sistemas de gerenciamento acadêmico da instituição. Criado por Luiz Gustavo, Pedro Lucas da Silva e Rafael Santos, o projeto visa facilitar o acesso e a distribuição de artigos acadêmicos produzidos pelos estudantes da universidade, promovendo a disseminação de conhecimento e incentivando a pesquisa e a colaboração acadêmica."),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          "Objetivo",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: const Text(
                            "O principal objetivo do UniPapers é agregar os sistemas de gerenciamento e acadêmicos da UNISO em uma plataforma acessível e eficiente. A proposta é criar um aplicativo mobile que permita a disseminação e distribuição de artigos acadêmicos de forma facilitada, oferecendo acesso livre a qualquer usuário interessado, dentro e fora da comunidade acadêmica."),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          "Desenvolvimento e Estrutura",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: const Text(
                            "O UniPapers foi inicialmente concebido no âmbito do componente curricular de Aplicações Mobile. A ideia central é criar um aplicativo que centralize a produção acadêmica dos alunos da UNISO, permitindo que os próprios estudantes gerenciem os dados e os artigos submetidos. O gerenciamento seria realizado sob a orientação de professores orientadores, garantindo a qualidade e a relevância do conteúdo disponibilizado."),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          "Próximos Passos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                        child: const Text(
                            "Atualmente, o UniPapers está em fase de demonstração, com o objetivo de obter aprovação para o desenvolvimento completo da aplicação e sua eventual integração com os sistemas da universidade. O grupo de desenvolvedores busca apoio institucional e recursos para transformar o protótipo em uma ferramenta plenamente funcional, que possa ser integrada ao ambiente acadêmico da UNISO."),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
