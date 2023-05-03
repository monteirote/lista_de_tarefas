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
  bool listaARealizarEstaAberta = false;
  bool modoEdicao = false;

  void _entrarModoEdicao() {
    setState(() {
      modoEdicao = true;
    });
  }

  void _sairModoEdicao() {
    setState(() {
      modoEdicao = false;
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
    // espaço para o header
    Task(
      nome: '',
      id: '',
      desc: '',
      concluida: false,
      expirationDate: DateTime.now(),
    ),
  ];

  final List<Task> doneTasks = [
    // espaço para o header
    Task(
        nome: '',
        concluida: true,
        desc: '',
        id: Random().toString(),
        expirationDate: DateTime.now()),
  ];

  final List<Task> apenasTitulo = [
    Task(
        nome: '',
        desc: '',
        id: '',
        expirationDate: DateTime.now(),
        concluida: false),
  ];

  _addTask(String nome, String desc, DateTime data) {
    final newTask = Task(
      concluida: false,
      nome: nome,
      desc: desc,
      expirationDate: data,
      id: Random().nextDouble().toString(),
    );

    setState(() {
      tasks.add(newTask);
    });
  }

  _setTaskAsDone(Task task) {
    setState(() {
      task.expirationDate = DateTime.now();
      task.concluida = true;
      tasks.remove(task);
      doneTasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: modoEdicao == false
                    ? Text(
                        titles[_selectedIndex],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        color: Theme.of(context).colorScheme.secondary,
                      )),
            _selectedIndex == 0
                ? modoEdicao == false
                    ? TextButton(
                        onPressed: _entrarModoEdicao,
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                    : Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: TextButton(
                          onPressed: _sairModoEdicao,
                          child: Text(
                            'Concluído',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
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
                    markAsDone: _setTaskAsDone,
                    listaEstaAberta: listaARealizarEstaAberta,
                    abrirFecharLista: _expandirListaARealizar,
                    tasks: tasks.isEmpty ? apenasTitulo : tasks,
                    titulo: 'Tarefas a Realizar',
                  ),
                  TaskList(
                    markAsDone: _setTaskAsDone,
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
