import 'package:flutter/material.dart';

class ListaTarefaPage extends StatelessWidget {
  const ListaTarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<
      Map<String, dynamic>
    > //variavel do tipo list pode ser associada a um array simples, dentro dos sinais de maior e menos colocamos o tipo de dado que irá entrar, caso seja variado podemos deixar sem nada. Nesse caso a chave será string e o valor será dinâmico
    tarefas = [
      {'titulo': 'Fazer compras', 'situacao': false},
      {'titulo': 'Lavar roupas', 'situacao': true},
      {'titulo': 'Pagar contas', 'situacao': false},
      {'titulo': 'Fazer tarefa', 'situacao': true},
      {"titulo": 'Limpar casa', 'situacao': false},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        //pense nele como um container, listview sozinho trabalha com dados estáticos
        padding: EdgeInsets.all(12),
        itemCount: tarefas
            .length, //define a quantidade de elementos associadas a lista que criamos
        itemBuilder: (context, index) {
          // children: [// esse elemento não existe em listview.builder, é substituido por itemBuilder
          // for (var i = 1; i <= 50; i++) ...[
          //   //para criar u,a estrutura de repetição FOR se precisar
          //   Text("Item 1"),
          // ],

          final tarefa =
              tarefas[index]; //criamos uma variavel para receber cada uma das tarefas da lista

          final bool situacao = tarefa["situacao"];

          return Card(
            child: ListTile(
              leading: Icon(
                situacao ? Icons.check_circle : Icons.circle_outlined,
                color: situacao ? Colors.green : Colors.grey,
              ),
              title: Text(
                tarefa["titulo"],
                style: TextStyle(
                  decoration: situacao
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(situacao ? "Concluida" : "Pendente"),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          );
        },
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
