import 'package:fast_trivia/data/task_dao.dart';
import 'package:fast_trivia/models/question.dart';
import 'package:fast_trivia/ui/pages/view_answer.dart';
import 'package:flutter/material.dart';

import '../ui/pages/check_answers.dart';

class Task extends StatefulWidget {
  final String id;
  final String total;
  final String corretas;
  final String erradas;
  final String categoria;
  final String quiz;
  final String answers;

  Task(
    this.id,
    this.total,
    this.corretas,
    this.erradas,
    this.categoria,
    this.quiz,
    this.answers, [
    Key? key,
  ]) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade800),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Text('Id do quiz: '),
                            SizedBox(
                                width: 120,
                                child: Text(
                                  widget.id,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Text('Total de questões: '),
                            SizedBox(
                                width: 40,
                                child: Text(
                                  widget.total,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Text('Total de acertos: '),
                            SizedBox(
                                width: 50,
                                child: Text(
                                  widget.corretas,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Text('Total de erros: '),
                            SizedBox(
                                width: 50,
                                child: Text(
                                  widget.erradas,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                        SizedBox(
                          height: 52,
                          width: 52,
                          child: ElevatedButton(
                              onPressed: () {
                                TaskDao().delete(widget.id);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Deletando a Tarefa'),
                                ));
                                setState(() {}); // print(nivel);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Icon(Icons.delete),
                                ],
                              )),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text(
                widget.categoria,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
