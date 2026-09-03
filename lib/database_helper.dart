import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db; //variável estática

  //função que cria tabela no BG
  //função assincróna é chamada na hora de execução do app,mas trabalha por debaixo dos panos, deixa o app mais respponsivo

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

  static Future<Database> get database async {
    _db ??=
        await abrirBanco(); //variavel estática na memoria do celular, ele vai verificar se o banco de dados está aberto, verifica na memoria.
    return _db!;
  }
}
