import 'package:flutter/material.dart';

class SobreAppPage extends StatelessWidget {
  const SobreAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre APP"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, //alinha no eixo vertical, o cross no horizontal
            children: [
              Image.asset(
                "assets/img/logo.png",
                width: 130,
                height: 130,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Aplicativo de gestão de tarefas, desenvolvido para ajudar na organizaçãodas atividades do dia a dia. Permite cadastrar, visualizar, filtrar e acompanhar tarefas, facilitando o controle das atividades pendentes e concluidas de forma simples e prática.",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Versão 1.0.0",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
