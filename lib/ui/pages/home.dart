import 'package:fast_trivia/data/task_dao.dart';
import 'package:fast_trivia/models/category.dart';
import 'package:fast_trivia/models/question.dart';
import 'package:fast_trivia/resources/tasks.dart';
import 'package:fast_trivia/ui/widgets/quiz_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          backgroundColor: Colors.yellow.shade800,
          title: Text('Fast Trivia'),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade800),
                height: 200,
              ),
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 80),
                    child: Text(
                      "Selecione a categoria do questionário desejado",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1000
                                  ? 7
                                  : MediaQuery.of(context).size.width > 600
                                      ? 5
                                      : 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0),
                      delegate: SliverChildBuilderDelegate(
                        _buildCategoryItem,
                        childCount: 2,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400, bottom: 0),
              child: FutureBuilder<List<Task>>(
                  future: TaskDao().findAll(),
                  builder: (context, snapshot) {
                    List<Task>? items = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Column(
                            children: const [
                              CircularProgressIndicator(),
                              Text('Carregando'),
                            ],
                          ),
                        );

                      case ConnectionState.waiting:
                        return Center(
                          child: Column(
                            children: const [
                              CircularProgressIndicator(),
                              Text('Carregando'),
                            ],
                          ),
                        );
                      case ConnectionState.active:
                        return Center(
                          child: Column(
                            children: const [
                              CircularProgressIndicator(),
                              Text('Carregando'),
                            ],
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasData && items != null) {
                          if (items.isNotEmpty) {
                            return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Task tarefa = items[index];
                                  return tarefa;
                                });
                          }
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // não implementado em vídeo por descuido meu, desculpem.
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // essa linha de layout deixa o conteudo totalmente centralizado.
                            children: const [
                              Icon(
                                Icons.error_outline,
                                size: 128,
                              ),
                              Text(
                                'Não há nenhum questionário respondido',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ));
                        }
                        return const Text('Erro ao carregar tarefas');
                    }
                    return const Text('Erro desconhecido');
                  }),
            ),
          ],
        ));
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    Category category = categories[index];
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => _categoryPressed(context, category),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      color: Colors.black,
      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (category.icon != null) Icon(category.icon),
          if (category.icon != null) SizedBox(height: 5.0),
          AutoSizeText(
            category.name,
            minFontSize: 10.0,
            textAlign: TextAlign.center,
            maxLines: 3,
            wrapWords: false,
          ),
        ],
      ),
    );
  }

  _categoryPressed(BuildContext context, Category category) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(
          category: category,
        ),
        onClosing: () {},
      ),
    );
  }
}
