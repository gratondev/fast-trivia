import 'package:fast_trivia/data/database.dart';
import 'package:fast_trivia/resources/tasks.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_id TEXT, '
      '$_total TEXT, '
      '$_corretas TEXT, '
      '$_erradas TEXT, '
      '$_categoria TEXT, '
      '$_quiz TEXT, '
      '$_answers TEXT)';

  static const String _tablename = 'quizTable';
  static const String _id = 'id';
  static const String _total = 'total';
  static const String _corretas = 'corretas';
  static const String _erradas = 'erradas';
  static const String _categoria = 'categoria';
  static const String _quiz = 'quiz';
  static const String _answers = 'answers';

  save(Task tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.id);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('a Tarefa não Existia.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('a Tarefa existia!');
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_id = ?',
        whereArgs: [tarefa.id],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_id] = tarefa.id;
    mapaDeTarefas[_total] = tarefa.total;
    mapaDeTarefas[_corretas] = tarefa.corretas;
    mapaDeTarefas[_erradas] = tarefa.erradas;
    mapaDeTarefas[_categoria] = tarefa.categoria;
    mapaDeTarefas[_quiz] = tarefa.quiz;
    mapaDeTarefas[_answers] = tarefa.answers;

    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        linha[_id],
        linha[_total],
        linha[_corretas],
        linha[_erradas],
        linha[_categoria],
        linha[_quiz],
        linha[_answers],
      );
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas: ${tarefas.toString()}');
    return tarefas;
  }

  Future<List<Task>> find(String idDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    print('Procurando tarefa com o id: ${idDaTarefa}');
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_id = ?', whereArgs: [idDaTarefa]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  delete(String idDaTarefa) async {
    print('Deletando tarefa: $idDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_id = ?',
      whereArgs: [idDaTarefa],
    );
  }
}
