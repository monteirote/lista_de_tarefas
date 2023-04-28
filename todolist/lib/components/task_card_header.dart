// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  final String titulo;
  final bool listaEstaAberta;
  final Function() abrirFecharLista;

  const ListHeader({
    required this.listaEstaAberta,
    required this.titulo,
    required this.abrirFecharLista,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(68, 138, 255, 1),
          borderRadius: listaEstaAberta 
          ? const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))
          : const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 174, 224, 244),
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () => abrirFecharLista(),
            icon: listaEstaAberta
                ? const Icon(Icons.remove)
                : const Icon(Icons.add),
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}
