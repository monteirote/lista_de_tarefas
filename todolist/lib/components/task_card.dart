// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    required this.deleteTask,
    required this.index,
    required this.tasks,
    required this.tsk,
    required this.markAsDone,
    required this.modoEdicao,
    required this.selecionarTask,
    required this.check,
  });

  final int index;
  final List<Task> tasks;
  final Task tsk;
  Function(Task) markAsDone;
  Function(Task, List) deleteTask;
  void Function(bool?) selecionarTask;
  bool modoEdicao;
  bool check;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(68, 138, 255, 1),
          borderRadius: BorderRadius.only(
            bottomLeft: index == tasks.length - 1
                ? const Radius.circular(10)
                : Radius.zero,
            bottomRight: index == tasks.length - 1
                ? const Radius.circular(10)
                : Radius.zero,
          )),
      child: Card(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 7.5),
        child: ListTile(
          horizontalTitleGap: 130,
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          tileColor: const Color.fromARGB(255, 174, 224, 244),
          title: Text(
            textAlign: TextAlign.left,
            tsk.nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          subtitle: Column(            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tsk.desc,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              Text(
                  tsk.concluida == false
                  ? 'Realizar até ${DateFormat('dd MMM y').format(tsk.expirationDate)} às ${DateFormat('hh:mm').format(tsk.expirationDate)}'
                  : 'Concluída em ${DateFormat('dd MMM y').format(tsk.expirationDate)}',
                  style: TextStyle(
                    fontSize: 11,
                    color: tsk.expirationDate.isBefore(DateTime.now()) && tsk.concluida == false ?  Colors.red : Colors.grey,
                  ),  
                ),
            ],
          ),
          trailing: 
          modoEdicao == true
          ? Checkbox(
            value: check,
            onChanged: selecionarTask,
            checkColor: Theme.of(context).primaryColor,
          )

          
          : tsk.concluida == false
            ? PopupMenuButton<int>(
            padding: const EdgeInsets.only(right: 10),
            icon: const Icon(Icons.done_outline_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {
                            markAsDone(tsk),
                            Navigator.of(context).pop()
                          },
                          child: const Text(
                            'Marcar como Concluída',
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancelar',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
          : PopupMenuButton<int>(
            padding: const EdgeInsets.only(right: 10),
            icon: const Icon(Icons.delete),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => {
                            deleteTask(tsk, tasks),
                            Navigator.of(context).pop()
                          },
                          child: const Text(
                            'Excluir Tarefa',
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancelar',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
    
  }
}
