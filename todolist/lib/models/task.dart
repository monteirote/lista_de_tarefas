class Task {
  
  final String id;
  final String nome;
  final String desc;
  DateTime expirationDate;
  bool concluida;

  Task({
    required this.id,
    required this.nome,
    required this.expirationDate,
    required this.desc,
    required this.concluida,
  });

}