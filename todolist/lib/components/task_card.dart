// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.index,
    required this.tasks,
    required this.tsk,
  });

  final int index;
  final List<Task> tasks;
  final Task tsk;

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
                  'Realizar até ${DateFormat('dd MMM y').format(tsk.expirationDate)} às ${DateFormat('hh:mm').format(tsk.expirationDate)}',
                  style: TextStyle(
                    fontSize: 11,
                    color: tsk.expirationDate.isBefore(DateTime.now()) ?  Colors.red : const Color.fromARGB(0, 78, 71, 71)
                  ),  
                ),
            ],
          ),
          trailing: PopupMenuButton<int>(
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
                          onPressed: () {},
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
          ),
        ),
      ),
    );
    ;
  }
}
