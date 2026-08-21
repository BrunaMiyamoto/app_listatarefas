import 'package:flutter/material.dart';

class ListaTarefaPage extends StatelessWidget {
  const ListaTarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // for (var i = 1; i <= 50; i++) ...[
          //   //para criar u,a estrutura de repetição FOR se precisar
          //   Text("Item 1"),
          // ],
          Card(
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text("Configurar o ambiente de desenvolvimento"),
              subtitle: Text("Concluida."),
            ),
          ),
        ],
      ),
    );
  }
}
