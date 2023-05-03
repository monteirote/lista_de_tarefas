import 'package:flutter/material.dart';
import 'package:todolist/components/task_card.dart';
import 'package:todolist/components/task_card_header.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final String titulo;
  final void Function() abrirFecharLista;
  final bool listaEstaAberta;
  Function(Task) markAsDone;
  Function(Task, List) deleteTask;
  bool modoEdicao;
  Function(bool?) selecionarTask;

  TaskList({
    super.key,
    required this.selecionarTask,
    required this.modoEdicao,
    required this.deleteTask,
    required this.listaEstaAberta,
    required this.tasks,
    required this.titulo,
    required this.abrirFecharLista,
    required this.markAsDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 331,
      color: const Color.fromARGB(255, 174, 224, 244),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(68, 138, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (ctx, index) {
                      final tsk = tasks[index];
                      return index == 0
                          ? ListHeader(
                              listaEstaAberta: listaEstaAberta,
                              titulo: titulo,
                              abrirFecharLista: abrirFecharLista,
                            )
                          : listaEstaAberta 
                          ? TaskCard(
                              selecionarTask: selecionarTask,
                              check: true,
                              modoEdicao: modoEdicao,
                              deleteTask: deleteTask,
                              markAsDone: markAsDone,
                              index: index,
                              tasks: tasks,
                              tsk: tsk,
                          )
                          : const SizedBox();
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
