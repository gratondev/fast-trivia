import 'dart:io';
import 'package:fast_trivia/models/category.dart';
import 'package:fast_trivia/models/question.dart';
import 'package:fast_trivia/resources/api_provider.dart';
import 'package:fast_trivia/ui/pages/error.dart';
import 'package:fast_trivia/ui/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class QuizOptionsDialog extends StatefulWidget {
  final Category? category;

  const QuizOptionsDialog({Key? key, this.category}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int? _noOfQuestions;
  String? _difficulty;
  late bool processing;

  @override
  void initState() {
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "medium";
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Text(
              widget.category!.name,
              style: Theme.of(context).textTheme.headline6!.copyWith(),
            ),
          ),
          SizedBox(height: 10.0),
          Text("Número total de questões:"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("5"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 10
                      ? Colors.yellow.shade800
                      : Colors.grey.shade600,
                  onPressed: () => _selectNumberOfQuestions(10),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text("Dificuldade do questionário:"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("Medium"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _difficulty == "medium"
                      ? Colors.yellow.shade800
                      : Colors.grey.shade600,
                  onPressed: () => _selectDifficulty("medium"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Iniciar"),
                  onPressed: _startQuiz,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  _selectDifficulty(String? s) {
    setState(() {
      _difficulty = s;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing = true;
    });
    try {
      List<Question> questions =
          await getQuestions(widget.category!, _noOfQuestions, _difficulty);
      Navigator.pop(context);
      if (questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ErrorPage(
                  message:
                      "There are not enough questions in the category, with the options you selected.",
                )));
        return;
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => QuizPage(
                    questions: questions,
                    category: widget.category,
                  )));
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ErrorPage(
                    message:
                        "Não foi possível se conectar aos servidores, \n Verifique sua conexão de internet.",
                  )));
    } catch (e) {
      print(e.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ErrorPage(
                    message: "Erro inesperado ao tentar conectar à API",
                  )));
    }
    setState(() {
      processing = false;
    });
  }
}
