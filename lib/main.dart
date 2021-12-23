export 'package:mobile_applications_project/main.dart';
import 'package:intl/intl.dart';
import 'package:mobile_applications_project/calcLogic.dart';
import 'package:flutter/material.dart';
import 'package:mobile_applications_project/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mobile_applications_project/converter.dart';
import 'package:mobile_applications_project/historyPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_applications_project/firebaseAPI.dart';

void main() {
  runApp(CalcLogic());
}

// teal 0xFF00796B
// light teal 0xFF80CBC4
// coral 0xFFFF6E40
// pale orange 0xFFFFB74D
// pale pink 0xFFF48FB1

class Calc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Calculator();
}

class Calculator extends State<CalcLogic> {
  String _history = '';
  String _expression = '';
  final navigatorKey = GlobalKey<NavigatorState>();
  String storehystory = '';
  List<String> previousCalc = [];
  SharedPreferences prefs;

  void numClick(String text) {
    setState(() {
      _expression += text;
    });
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void evaluate(String text) async {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    DateTime now = DateTime.now();
    String formatDate = DateFormat('MMM dd, yyyy kk:mm').format(now);

    setState(() {
      _history = _expression;
      _expression = eval.toString();
      storehystory =
          'Equations:: " $_history = $_expression " \n timestamp:: $formatDate';
    });
    prefs = await SharedPreferences.getInstance();
    prefs.setString(DateTime.now().toString(), storehystory);
    setState(() {
      previousCalc.add(storehystory);
    });
    addDataToFirebase(_expression);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      navigatorKey: navigatorKey,
      home: Scaffold(
        backgroundColor: Color(0xFF00796B),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 12),
            child: Text(
              _history,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: 22,
                ),
                color: Colors.white30,
              ),
            ),
            alignment: Alignment.bottomRight,
          ),
          Container(
            padding: EdgeInsets.all(17),
            child: Text(
              _expression,
              style: GoogleFonts.rubik(
                textStyle: TextStyle(
                  fontSize: 42,
                ),
                color: Colors.white,
              ),
            ),
            alignment: Alignment.bottomRight,
          ),
          RaisedButton(
              onPressed: () {
                navigatorKey.currentState.push(
                  MaterialPageRoute(builder: (context) => RouteToConverter()),
                );
              },
              child: Text("converter")),
          RaisedButton(
              onPressed: () {
                navigatorKey.currentState.push(
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              child: Text("history")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: 'AC',
                callback: allClear,
                fillColor: 0xFFFF6E40,
              ),
              Button(
                text: 'C',
                callback: clear,
                fillColor: 0xFF6C807F,
              ),
              Button(
                text: '%',
                callback: numClick,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
              Button(
                text: '/',
                callback: numClick,
                textSize: 30,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: '7',
                callback: numClick,
              ),
              Button(
                text: '8',
                callback: numClick,
              ),
              Button(
                text: '9',
                callback: numClick,
              ),
              Button(
                text: '*',
                callback: numClick,
                textSize: 30,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: '4',
                callback: numClick,
              ),
              Button(
                text: '5',
                callback: numClick,
              ),
              Button(
                text: '6',
                callback: numClick,
              ),
              Button(
                text: '-',
                callback: numClick,
                textSize: 30,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: '1',
                callback: numClick,
              ),
              Button(
                text: '2',
                callback: numClick,
              ),
              Button(
                text: '3',
                callback: numClick,
              ),
              Button(
                text: '+',
                callback: numClick,
                textSize: 30,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: '.',
                callback: numClick,
                textSize: 30,
              ),
              Button(
                text: '0',
                callback: numClick,
              ),
              Button(
                text: '00',
                callback: numClick,
              ),
              Button(
                text: '=',
                callback: evaluate,
                textSize: 30,
                fillColor: 0xFF80CBC4,
                textColor: 0xFFFF6E40,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
