import 'package:fast_trivia/ui/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Trivia',
      theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: Colors.yellow,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          fontFamily: "Montserrat",
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textTheme: ButtonTextTheme.primary)),
      home: HomePage(),
    );
  }
}
