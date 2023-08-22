import 'dart:convert';

import 'package:fast_trivia/data/task_dao.dart';
import 'package:fast_trivia/models/question.dart';
import 'package:fast_trivia/resources/tasks.dart';
import 'package:fast_trivia/ui/pages/check_answers.dart';
import 'package:flutter/material.dart';

class QuizFinishedPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;

  QuizFinishedPage({
    Key? key,
    required this.questions,
    required this.answers,
  }) : super(key: key);

  @override
  _QuizFinishedPageState createState() => _QuizFinishedPageState();
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
  int? correctAnswers;

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    this.widget.answers.forEach((index, value) {
      if (this.widget.questions[index].correctAnswer == value) correct++;
    });
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Colors.yellow.shade800,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: Text('Resultado'),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.shade900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Total de questões", style: titleStyle),
                  trailing:
                      Text("${widget.questions.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Score", style: titleStyle),
                  trailing: Text("${correct / widget.questions.length * 100}%",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    "Questões corretas",
                    style: titleStyle,
                  ),
                  trailing: Text("$correct/${widget.questions.length}",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Questões erradas", style: titleStyle),
                  trailing: Text(
                      "${widget.questions.length - correct}/${widget.questions.length}",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.8),
                      ),
                      child: Text("Voltar para home"),
                      onPressed: () {
                        TaskDao().save(Task(
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          "${widget.questions.length}",
                          "$correct/${widget.questions.length}",
                          "${widget.questions.length - correct}/${widget.questions.length}",
                          "${widget.questions}",
                          "${widget.answers}",
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Criando uma nova Tarefa'),
                          ),
                        );
                        Navigator.pop(context);
                      }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.yellow.shade800,
                    ),
                    child: Text("Verificar Repostas"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CheckAnswersPage(
                                questions: widget.questions,
                                answers: widget.answers,
                              )));

                      TaskDao().save(
                        Task(
                          DateTime.now().millisecondsSinceEpoch.toString(),
                          "${widget.questions.length}",
                          "$correct/${widget.questions.length}",
                          "${widget.questions.length - correct}/${widget.questions.length}",
                          "${widget.questions}",
                          "${widget.answers}",
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Criando uma nova Tarefa'),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
