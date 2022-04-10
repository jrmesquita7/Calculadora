// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  int numeroDisplay = 0;
  var display = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora'),
          backgroundColor: Colors.black,
        ),
        body: Column( 
          children: [
            Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Flexible(
                      child: Text(
                    display.toString(),
                    style: const TextStyle(fontSize: 70),
                  ))
                ])),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 1, crossAxisSpacing: 1,
              crossAxisCount: 5,
              children: [
                botao("7", numero: 7),
                botao("8", numero: 8),
                botao("9", numero: 9),
                botao("/"),
                botao("C", color: Colors.black),
                botao("4", numero: 4),
                botao("5", numero: 5),
                botao("6", numero: 6),
                botao("x"),
                botao("½"),
                botao("1", numero: 1),
                botao("2", numero: 2),
                botao("3", numero: 3),
                botao("-"),
                botao("√"),
                botao("0", numero: 0),
                botao("."),
                botao("%"),
                botao("+"),
                botao("=", color: Colors.green),
              ],
            )
          ],
        ));
  }

  botao(String text, {int? numero, Color color = Colors.grey}) {
    return GestureDetector(
      child: Container(
          width: 50,
          height: 100,
          color: color,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          )),
      onTap: () {
        setState(() {
          if (numero != null) {
            display += numero.toString();
          } else if (text == 'C') {
            setState(() {
              display = '';
            });
          } else if (text == '+' ||
              text == 'x' ||
              text == '-' ||
              text == '/' ||
              text == '√' ||
              text == '.') {
            setState(() {
              display += text.toString();
            });
          } else if (text == '=') {
            estateResult();
            setState(() {
              display = result.toString();
            });
          }
        });
      },
    );
  }

  void estateResult() {
    String displayMultiplicacao = display;
    displayMultiplicacao = display.replaceAll('x', "*");
    Parser p = Parser();
    Expression exp = p.parse(displayMultiplicacao);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}
