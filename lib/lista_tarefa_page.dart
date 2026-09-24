import 'package:app_listatarefas/database_helper.dart';
import 'package:app_listatarefas/sobre_app_page.dart';
import 'package:flutter/material.dart';

class ListaTarefaPage extends StatefulWidget {
  const ListaTarefaPage({super.key});

  @override
  State<ListaTarefaPage> createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  List<Map<String, dynamic>> tarefas = [];

  String? filtroAtual;

  static const categorias = ['Pessoal', 'Trabalho', 'Estudo', 'Compras'];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  void carregarTarefas() async {
    final dados = await DatabaseHelper.buscarTarefas(filtro: filtroAtual);
    setState(() {
      tarefas = dados;
    });
  }

  void aplicarFiltro(
    String? novoFiltro,
  ) //função void não permite return, só executa o que está definido
  {
    filtroAtual = novoFiltro;
    Navigator.pop(context);
    carregarTarefas();
  }

  Future<void> marcarSituacao(int index) async {
    final tarefa = tarefas[index];
    final novoValor = tarefa['situacao'] == 1 ? 0 : 1;

    await DatabaseHelper.atualizarTarefa(
      tarefa["id"],
      novoValor,
    ); //chamamos o banco de dados, selecionamos a tarefa pelo id e atribuimos o novo valor, se for 1, muda para 0 e vice e versa

    carregarTarefas(); //sempre devemos chamar essa função no final de cada função nova
  }

  Future<void> deletarTarefa(int index) async {
    final tarefa = tarefas[index];

    await DatabaseHelper.deletarTarefa(tarefa["id"]);

    carregarTarefas();
  }

  void adicionarTarefa() {
    final novaTarefaController = TextEditingController();

    String categoriaEscolhida =
        categorias.first; //pega a primeira categoria escolhida pelo usuário

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Nova tarefa"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: novaTarefaController,
                    decoration: InputDecoration(
                      hintText: 'Digite o título...',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  DropdownButton<String>(
                    value:
                        categoriaEscolhida, // vai guardar a informação da opção selecionada
                    isExpanded: true,
                    items: categorias.map(
                      //faz um laço dentro da lista de categorias
                      (categoria) {
                        return DropdownMenuItem(
                          value:
                              categoria, //a informação que você quer jogar no bd
                          child: Text(categoria),
                        );
                      },
                    ).toList(),
                    onChanged: (novaCategoria) {
                      setStateDialog(() {
                        categoriaEscolhida = novaCategoria!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    //função para fechar qualquer janela/tela
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (novaTarefaController.text.isNotEmpty) {
                      await DatabaseHelper.inserirTarefa(
                        novaTarefaController.text,
                        categoriaEscolhida,
                      );
                      carregarTarefas();

                      if (!context.mounted) return;

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Adicionar',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                "Minhas Tarefas",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Todas as tarefas"),
              selected:
                  filtroAtual ==
                  null, //deixa em outra cor a opção selecionada, deixa em destaque
              onTap: () => aplicarFiltro(null),
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Concluídas"),
              selected: filtroAtual == "concluidas",
              onTap: () => aplicarFiltro("concluidas"),
            ),
            ListTile(
              leading: Icon(Icons.circle_outlined),
              title: Text("Pendentes"),
              selected: filtroAtual == "pendentes",
              onTap: () => aplicarFiltro("pendentes"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Sobre o APP"),
              onTap: () {
                Navigator.pop(context); //fecha o menu ao clicar
                Navigator.push(
                  //chamamos a página que queremos
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SobreAppPage(), //precisa colocar underline rentre parênteses
                  ),
                );
              },
            ),
          ],
        ),
      ), //menu hamburguer
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa ainda. Clique em + para adicionar uma',
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                final bool situacao = tarefa['situacao'] == 1;
                final String categoria =
                    tarefa['categoria'] ??
                    'Sem Categoria'; //caso o usuário não tenha categoria selecionada, nos casos de usuários que baixaram na versão anterior na qual não tinha essa opção

                return Card(
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () => marcarSituacao(index),
                      child: Icon(
                        situacao ? Icons.check_circle : Icons.circle_outlined,
                        color: situacao ? Colors.green : Colors.grey,
                      ),
                    ),
                    title: Text(
                      tarefa['titulo'],
                      style: TextStyle(
                        decoration: situacao
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      '${situacao ? "Concluída" : 'Pendente'} - $categoria',
                    ),
                    trailing: GestureDetector(
                      onTap: () => deletarTarefa(index),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            adicionarTarefa(), //pode chamar direto, só colocando o nome da "variável", pq o flutter é inteligente para saber o que vc está tentando fazer
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        //shape:CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}

// class ListaTarefaPage extends StatelessWidget {
//   const ListaTarefaPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<
//       Map<String, dynamic>
//     > //variavel do tipo list pode ser associada a um array simples, dentro dos sinais de maior e menos colocamos o tipo de dado que irá entrar, caso seja variado podemos deixar sem nada. Nesse caso a chave será string e o valor será dinâmico
//     tarefas = [
//       {'titulo': 'Fazer compras', 'situacao': false},
//       {'titulo': 'Lavar roupas', 'situacao': true},
//       {'titulo': 'Pagar contas', 'situacao': false},
//       {'titulo': 'Fazer tarefa', 'situacao': true},
//       {"titulo": 'Limpar casa', 'situacao': false},
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Minhas Tarefas"),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         //pense nele como um container, listview sozinho trabalha com dados estáticos
//         padding: EdgeInsets.all(12),
//         itemCount: tarefas
//             .length, //define a quantidade de elementos associadas a lista que criamos
//         itemBuilder: (context, index) {
//           // children: [// esse elemento não existe em listview.builder, é substituido por itemBuilder
//           // for (var i = 1; i <= 50; i++) ...[
//           //   //para criar u,a estrutura de repetição FOR se precisar
//           //   Text("Item 1"),
//           // ],

//           final tarefa =
//               tarefas[index]; //criamos uma variavel para receber cada uma das tarefas da lista

//           final bool situacao = tarefa["situacao"];

//           return Card(
//             child: ListTile(
//               leading: Icon(
//                 situacao ? Icons.check_circle : Icons.circle_outlined,
//                 color: situacao ? Colors.green : Colors.grey,
//               ),
//               title: Text(
//                 tarefa["titulo"],
//                 style: TextStyle(
//                   decoration: situacao
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               ),
//               subtitle: Text(situacao ? "Concluida" : "Pendente"),
//               trailing: Icon(
//                 Icons.delete_outline,
//                 color: Colors.grey,
//               ),
//             ),
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//         //shape: CircleBorder(), deixa o botão arredondado
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
