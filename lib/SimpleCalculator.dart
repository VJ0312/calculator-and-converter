import 'package:calculator/CurrencyConverter.dart';
import 'package:calculator/VolumeConverter.dart';
import 'package:calculator/WeightConverter.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'DistanceConverter.dart';

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
          title: Text("Calculator"), // Title at top
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // styling value
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title: Text('Distance Conversion',
                      style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DistanceConvert(), // when "Distance Conversion" is pressed, switch screen to distance conversion screen
                        ));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title: Text('Currency Conversion',
                      style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrConvert(), // when "Currency Conversion" is pressed, switch screen to Currency conversion screen
                        ));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                  Text('Weight Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WeightConvert()));  // when "Weight Conversion" is pressed, switch screen to Weight conversion screen
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                  Text('Volume Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VolumeConvert())); // when "Volume Conversion" is pressed, switch screen to Volume conversion screen
                  },
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 10, 45, 0),
              child: Text(
                eqn, // Display expression at top
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 45, 0),
              child: Text(
                result, // Display evaluated expression below
                style: TextStyle(fontSize: 60),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
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
                  padding: EdgeInsets.only(top: 0),
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
                        padding: EdgeInsets.all(20),
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
                  padding: EdgeInsets.only(top: 0),
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
                        padding: EdgeInsets.all(20),
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
                        padding: EdgeInsets.all(20),
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
}
