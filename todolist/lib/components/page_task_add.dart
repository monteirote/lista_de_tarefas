// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {

  final void Function(String, String, DateTime) onSubmit;

  const AddTaskPage({
    required this.onSubmit
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final desc = _descController.text;

    if (title.isEmpty) {
      return;
    }

    widget.onSubmit(title, desc, _selectedDate);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 174, 224, 244),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Título',
            style: TextStyle(
                fontSize: 18,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          CupertinoTextField(
            placeholder: 'Título',
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            controller: _titleController,
            onSubmitted: (_) => {}
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Descrição',
            style: TextStyle(
                fontSize: 18,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold),
          ),
          CupertinoTextField(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            maxLines: 5,
            textAlignVertical: TextAlignVertical.top,
            placeholder: 'Descrição',
            controller: _descController,
            onSubmitted: (_) => {
              _submitForm,
              _descController.clear(),
              _titleController.clear(),
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Realizar até',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 120,
            child: CupertinoDatePicker(
              onDateTimeChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
              initialDateTime: DateTime.now(),
              minimumDate: DateTime.now().subtract(const Duration(minutes: 1)),
              maximumDate: DateTime(2024),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: _submitForm,
                child: const Text(
                  'Adicionar Tarefa',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
