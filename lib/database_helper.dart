import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db; //variável estática

  //função que cria tabela no BG
  //função assincróna é chamada na hora de execução do app,mas trabalha por debaixo dos panos, deixa o app mais respponsivo

  //Abre (pu cria, se não exite) o arquivo de banco de dados

  static Future<Database> abrirBanco() async {
    final caminho = join(
      await getDatabasesPath(),
      'tarefas.db',
    ); // await aguarda o caminho correto onde está salvo o BD, traz o caminho certo para a variável

    return openDatabase(
      caminho,
      version: 1, //mudando a versão o BD é reestruturado
      onCreate: (db, versao) {
        return db.execute(
          'CREATE TABLE tarefas (' //colocar aspas simples dentro dos parênteses
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'titulo TEXT,'
          'situacao INTEGER' // 0 para false e 1 ppara true
          ')',
        );
      },
    );
  }

  //Getter que devolve o banco de dados já aberto, ou abre se ainda não existe

  static Future<Database> get database async {
    _db ??=
        await abrirBanco(); //variavel estática na memoria do celular, ele vai verificar se o banco de dados está aberto, verifica na memoria.
    return _db!;
  }

  // READ: buscar todas as tarefas salvas dentro do banco

  static Future<List<Map<String, dynamic>>> buscarTarefas({
    String? filtro,
  }) async {
    final db = await DatabaseHelper.database;

    if (filtro == "pendentes") {
      return db.query(
        "tarefas",
        where: "situacao = ?",
        whereArgs: [
          0,
        ], //se a tarefa for igual a pendentes e está com a situação 0 ela é retornada
      );
    }

    if (filtro == "concluidas") {
      return db.query(
        "tarefas",
        where: "situacao = ?",
        whereArgs: [
          1,
        ], //se a tarefa for igual a concluidas e está com a situação 1 ela é retornada
      );
    }

    return db.query("tarefas"); // select * from tarefas
  }

  //CREATE inserir uma njova tarefa no banco de dados
  static Future<void> inserirTarefa(String titulo) async {
    final db = await DatabaseHelper.database;
    await db.insert("tarefas", {
      'titulo': titulo,
      'situacao': 0,
    });
  }

  //UPDATE atualização da situação da tarefa
  static Future<void> atualizarTarefa(int id, int situacao) async {
    final db = await DatabaseHelper
        .database; //clicar na lâmpada e add async para o erro sumir
    await db.update(
      'tarefas',
      {'situacao': situacao},
      where: 'id = ?', // usamos o parâmetro ? para evitar sql injector
      whereArgs: [id],
    );
  }

  //DELETE deletar uma tarefa do banco de dados
  static Future<void> deletarTarefa(int id) async {
    final db = await DatabaseHelper.database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
