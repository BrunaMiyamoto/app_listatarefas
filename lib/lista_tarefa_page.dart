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
        //pense nele como um container
        padding: EdgeInsets.all(12),
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
              title: Text(
                "Configurar o ambiente de desenvolvimento",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text("Concluida"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(
                Icons.circle_outlined,
                color: Colors.grey,
              ),
              title: Text(
                "Fazer a atividade Flutter",
              ),
              subtitle: Text("Pendente"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(
                "Iniciar layout Mobile",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text("Concluida"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        //shape: CircleBorder(), deixa o botão arredondado
        child: Icon(Icons.add),
      ),
    );
  }
}
