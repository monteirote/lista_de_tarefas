// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/components/page_task_add.dart';
import 'package:todolist/components/task_list.dart';
import 'models/task.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: criarMaterialColor(const Color.fromRGBO(68, 138, 255, 1)),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary:
              criarMaterialColor(const Color.fromARGB(255, 174, 224, 244)),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

MaterialColor criarMaterialColor(Color cor) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = {};
  final int r = cor.red, g = cor.green, b = cor.blue;

  for (int strength in strengths) {
    final double opacity = strength / 1000.0;
    swatch[strength] = Color.fromRGBO(r, g, b, opacity);
  }
  return MaterialColor(cor.value, swatch);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool listaConcluidasEstaAberta = false;
  bool listaARealizarEstaAberta = true;
  bool modoEdicao = false;

  void _entrarModoEdicao() {
    setState(() {
      modoEdicao = true;
    });

  }

  void _expandirListaConcluidas() {
    setState(() {
      listaConcluidasEstaAberta = !listaConcluidasEstaAberta;
    });
  }

  void _expandirListaARealizar() {
    setState(() {
      listaARealizarEstaAberta = !listaARealizarEstaAberta;
    });
  }

  final List<String> titles = [
    'Lista de Tarefas',
    'Adicionar Tarefa',
    'Configurações',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Task> tasks = [
    Task(
      nome: 'espaço para o título',
      id: '',
      desc: '',
      expirationDate: DateTime.now(),
    ),
    Task(
      nome: 'Regar Plantas',
      id: Random().toString(),
      desc: 'Regar todas as plantas do jardim',
      expirationDate: DateTime.now(),
    ),
    Task(
      nome: 'Estudar para Prova',
      id: Random().toString(),
      desc: 'Estudar para a prova de desenvolvimento de algorit.',
      expirationDate: DateTime.now(),
    ),
  ];
  _addTask(String nome, String desc, DateTime data) {
    final newTask = Task(
      nome: nome,
      desc: desc,
      expirationDate: data,
      id: Random().nextDouble().toString(),
    );

    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> doneTasks = [
      Task(
          nome: 'Teste 1',
          desc: 'Teste 1',
          id: Random().toString(),
          expirationDate: DateTime.now()),
      Task(
          nome: 'Teste 2',
          desc: 'Teste 2',
          id: Random().toString(),
          expirationDate: DateTime.now()),
      Task(
          nome: 'Teste 3',
          desc: 'Teste 3',
          id: Random().toString(),
          expirationDate: DateTime.now())
    ];

    final List<Task> apenasTitulo = [
      Task(nome: '', desc: '', id: '', expirationDate: DateTime.now()),
    ];

    return Scaffold(
      appBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.only(
          bottom: 5,
          start: 10,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                titles[_selectedIndex],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ),
            _selectedIndex == 0
                ? TextButton(
                    onPressed: _entrarModoEdicao,
                    child: Text(
                      'Editar',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      body: SafeArea(
        child: _selectedIndex == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TaskList(
                    listaEstaAberta: listaARealizarEstaAberta,
                    abrirFecharLista: _expandirListaARealizar,
                    tasks: tasks.isEmpty ? apenasTitulo : tasks,
                    titulo: 'Tarefas a Realizar',
                  ),
                  TaskList(
                    listaEstaAberta: listaConcluidasEstaAberta,
                    abrirFecharLista: _expandirListaConcluidas,
                    tasks: doneTasks.isEmpty ? apenasTitulo : doneTasks,
                    titulo: 'Tarefas Concluídas',
                  )
                ],
              )
            : _selectedIndex == 1
                ? AddTaskPage(
                    onSubmit: _addTask,
                  )
                : const Center(child: Text('oi3')),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(68, 138, 255, 1),
          fixedColor: const Color.fromARGB(255, 174, 224, 244),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Adicionar Tarefa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: (index) => _onItemTapped(index)),
    );
  }
}
