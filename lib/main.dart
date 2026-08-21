import 'package:app_listatarefas/lista_tarefa_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaTarefaPage(),
      theme: ThemeData(
        useMaterial3: true, //padrão mais novo do material
        colorSchemeSeed: Colors.indigo, //atribui uma cor tema para o app
        appBarTheme: AppBarTheme(
          //tema do nosso appbar
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
    ),
  );
}
