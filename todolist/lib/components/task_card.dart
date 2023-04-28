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
            tileColor: const Color.fromARGB(255, 174, 224, 244),
            title: Text(
              tsk.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(children: [
              Text(tsk.desc),
              Text(
                  'Realizar até ${DateFormat('dd MMM y').format(tsk.expirationDate)}')
            ]),
            trailing: const Icon(
              Icons.three_k_sharp,
            ),
          )),
    );
    ;
  }
}
