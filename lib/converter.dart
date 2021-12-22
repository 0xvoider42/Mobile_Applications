import 'package:mobile_applications_project/calcLogic.dart';
import 'package:flutter/material.dart';
import 'package:mobile_applications_project/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_applications_project/calcLogic.dart';
import 'package:mobile_applications_project/main.dart';

// teal 0xFF00796B
// light teal 0xFF80CBC4
// coral 0xFFFF6E40
// pale orange 0xFFFFB74D
// pale pink 0xFFF48FB1

class RouteToConverter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Converter();
}

class Converter extends State<RouteToConverter> {
  final controller_number = TextEditingController();
  final my_form_key = GlobalKey<FormState>();

  String textToShow = "";
  String _history = '';
  String _expression = '';
  final navigatorKey = GlobalKey<NavigatorState>();

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

  void KmToMiles(String text) {
    double number = double.parse(_expression);
    double result = number * 1.60934;
    setState(() {
      _expression = result.toString();
    });
  }

  void MilesToKm(String text) {
    double number = double.parse(_expression);
    double result = number * 0.621371;
    setState(() {
      _expression = result.toString();
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
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
                  MaterialPageRoute(builder: (context) => CalcLogic()),
                );
              },
              child: Text("calculator")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                text: 'km/mil',
                callback: KmToMiles,
                fillColor: 0xFFFF6E40,
              ),
              Button(
                text: 'mil/km',
                callback: MilesToKm,
                fillColor: 0xFF6C807F,
              ),
              Button(
                text: 'AC',
                callback: allClear,
                fillColor: 0xFFFF6E40,
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
            ],
          ),
        ]),
      ),
    );
  }
}
