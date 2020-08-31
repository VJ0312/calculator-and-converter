import 'package:calculator/TemperatureConverter.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'CurrencyConverter.dart';
import 'DistanceConverter.dart';
import 'WeightConverter.dart';
import 'VolumeConverter.dart';
import 'PressureConverter.dart';

String page;
bool switchToScientific = false;

class SimpleCalculator extends StatefulWidget {
  @override
  SimpleCalculatorState createState() => SimpleCalculatorState();
}

class SimpleCalculatorState extends State<SimpleCalculator> {
  String eqn = "0", result = "0", expression = "";
  bool next;
  //initialize variables

  void buttonPressed(text) {
    setState(() {
      if (text == "=") {
        expression = eqn;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");  // when "=" is pressed replace "×" and "÷" with "*" and "/" for computer readability
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}'; // evaluate expression
        } catch (e) {
          result = "Error"; // If invalid expression is entered, return "Error"
        }
      } else if (text == "⌫") {
        eqn = eqn.substring(0, eqn.length - 1);
        if (eqn == "") {
          eqn = "0"; // When "⌫" is pressed reduce length of string by 1
        }
      } else if (text == "C") {
        eqn = "0";
        result = "0"; // if "C" key is pressed set expression to 0
      } else if (eqn == "0") {
        eqn = text;
      } else {
        eqn = eqn + text;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              title: Text("Calculator"),
        ),
        drawer: drawerWidget(),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 10, 45, 0),
              child: Text(
                eqn, // Display expression at top
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 30, 40, 0),
              child: Text(
                result, // Display expression at top
                style: TextStyle(fontSize: 70),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                      ),
                      MaterialButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(20),
                        splashColor: Colors.grey,
                        shape: CircleBorder(),
                        height: 40.0,
                        minWidth: 70.0,
                        onPressed: () {
                          buttonPressed("C");
                        },
                        child: Text(
                          "C",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24),
                      ),
                      MaterialButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        splashColor: Colors.grey,
                        height: 70.0,
                        minWidth: 72.0,
                        shape: CircleBorder(),
                        onPressed: () {
                          buttonPressed("⌫");
                        },
                        child: Text(
                          "⌫",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22),
                      ),
                      MaterialButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        splashColor: Colors.grey,
                        shape: CircleBorder(),
                        height: 70.0,
                        minWidth: 70.0,
                        onPressed: () {
                          buttonPressed("%");
                        },
                        child: Text(
                          "%",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 22),
                      ),
                      MaterialButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        height: 70.0,
                        minWidth: 70.0,
                        shape: CircleBorder(),
                        splashColor: Colors.orangeAccent,
                        onPressed: () {
                          buttonPressed("÷");
                        },
                        child: Text(
                          "÷",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 22),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                      ),
                      numberButton(7),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                     numberButton(8),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      numberButton(9),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      MaterialButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(20),
                        height: 70.0,
                        shape: CircleBorder(),
                        minWidth: 70.0,
                        splashColor: Colors.orangeAccent,
                        onPressed: () {
                          buttonPressed("×");
                        },
                        child: Text(
                          "×",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                      ),
                      numberButton(4),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      numberButton(5),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      numberButton(6),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      MaterialButton(
                        color: Colors.orangeAccent,
                        height: 70.0,
                        minWidth: 70.0,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(20),
                        shape: CircleBorder(),
                        splashColor: Colors.orangeAccent,
                        onPressed: () {
                          buttonPressed("-");
                        },
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                      ),
                      numberButton(1),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      numberButton(2),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      numberButton(3),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      MaterialButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        height: 70.0,
                        minWidth: 70.0,
                        shape: CircleBorder(),
                        splashColor: Colors.orangeAccent,
                        onPressed: () {
                          buttonPressed("+");
                        },
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        height: 70.0,
                        minWidth: 70.0,
                        splashColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.lightBlueAccent)),
                        onPressed: () {
                          buttonPressed("0");
                        },
                        child: Text(
                          "     0     ",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        splashColor: Colors.blueAccent,
                        height: 70.0,
                        minWidth: 70.0,
                        shape: CircleBorder(),
                        onPressed: () {
                          buttonPressed(".");
                        },
                        child: Text(
                          ".",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                      ),
                      MaterialButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                        splashColor: Colors.orangeAccent,
                        onPressed: () {
                          buttonPressed("=");
                        },
                        height: 70.0,
                        minWidth: 70.0,
                        child: Text(
                          "=",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }


  Widget numberButton(int number) { // Create custom Widget with parameters
   return MaterialButton(
     color: Colors.blue,
     textColor: Colors.white,
     height: 70.0,
     minWidth: 70.0,
     splashColor: Colors.blueAccent,
     shape: CircleBorder(),
     onPressed: () {
       buttonPressed("$number");
     },
     child: Text(
       "$number",
       style: TextStyle(fontSize: 40.0),
     ),
   );
  }


  Widget drawerWidget() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // styling value
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title: Text('Converter',
                  style: TextStyle(fontSize: 30)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title: Text('Calculator',
                  style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Calculator";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SimpleCalculator(),
                    ));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title: Text('Distance Conversion',
                  style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Distance Conversion";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DistanceConvert(),
                    ));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title: Text('Currency Conversion',
                  style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Currency Conversion";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrConvert(),
                    ));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title:
              Text('Weight Conversion', style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Weight Conversion";
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeightConvert()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title:
              Text('Volume Conversion', style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Volume Conversion";
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VolumeConvert()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title:
              Text('Temperature Conversion', style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Temperature Conversion";
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TemperatureConvert()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title:
              Text('Pressure Conversion', style: TextStyle(fontSize: 25)),
              onTap: () {
                page = "Pressure Conversion";
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pressureConvert()));
              },
            ),
          )
        ],
      ),
    );
  }
}