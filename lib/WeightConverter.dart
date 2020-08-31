import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/Calculator.dart';
import 'DistanceConverter.dart';
import 'CurrencyConverter.dart';
import 'package:calculator/VolumeConverter.dart';
import 'TemperatureConverter.dart';
import 'PressureConverter.dart';

TextEditingController textC = TextEditingController();

class WeightConvert extends StatefulWidget {
  _WeightConvert createState() => _WeightConvert();
}

// same as Distance Convert and volume Convert

class _WeightConvert extends State<WeightConvert> {
  var weightDropDownValue = "Ounces", weightDropDown = "Pounds", inputValue;
  TextEditingController textC2 = TextEditingController();
  var convertedResult;

  _onFromChanged(String value) {
    setState(() {
      weightDropDownValue = value;
      print("weightDropDownValue $weightDropDownValue");
    });
  }

  _onToChanged(String value) {
    setState(() {
      weightDropDown = value;
      print("weightDropDown $weightDropDown");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Weight Converter")),
        drawer: drawerWidget(),
        body: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: ListTile(
                          title: TextField(
                            controller: textC,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                hintText:
                                    "Enter a value in $weightDropDownValue"),
                          ),
                          trailing: weightDropDownBut(weightDropDownValue)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: FlatButton(
                          child: Text(
                            "Convert",
                            style: TextStyle(fontSize: 30),
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              inputValue = textC.text;
                              textC2.text = MetricConversionTools().convert(
                                  inputValue,
                                  weightDropDownValue,
                                  weightDropDown);
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: ListTile(
                          title: TextField(
                            readOnly: true,
                            controller: textC2,
                            decoration: InputDecoration(
                                hintText: "conversion in $weightDropDown"),
                          ),
                          trailing: weightDropDownBut(weightDropDown)),
                    )
                  ],
                ),
              )),
        ) //: null,
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
  Widget weightDropDownBut(String disValue) {
    return DropdownButton(
      value: disValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      items: <String>[
        'Milligrams',
        'Grams',
        'Kilograms',
        'Ounces',
        'Pounds',
        'Stone',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          if (disValue == weightDropDownValue) {
            print("top");
            _onFromChanged(newValue);
          } else {
            print("bottom");
            _onToChanged(newValue);
          }
        });
      },
    );
  }
}

class MetricConversionTools {
  String convert(var input, var top, var bottom) {
    var answer = int.parse(input);
    double ans;
    if (top == "Milligrams") {
      if (bottom == "Grams") {
        ans = answer / 1000.0;
      } else if (bottom == "Kilograms") {
        ans = answer / 1000000.0;
      } else if (bottom == "Ounces") {
        ans = answer / 28350.0;
      } else if (bottom == "Pounds") {
        ans = answer / 453592.0;
      } else if (bottom == "Stone") {
        ans = answer / 5669904.625;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Grams") {
      if (bottom == "Milligrams") {
        ans = answer * 1000.0;
      } else if (bottom == "Kilograms") {
        ans = answer / 1000.0;
      } else if (bottom == "Ounces") {
        ans = answer / 28.35;
      } else if (bottom == "Pounds") {
        ans = answer / 454;
      } else if (bottom == "Stone") {
        ans = answer / 6350.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Kilograms") {
      if (bottom == "Milligrams") {
        ans = answer * 1000000.0;
      } else if (bottom == "Grams") {
        ans = answer / 1000.0;
      } else if (bottom == "Ounces") {
        ans = answer * 35.274;
      } else if (bottom == "Pounds") {
        ans = answer * 2.20462;
      } else if (bottom == "Stone") {
        ans = answer / 6.35;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Ounces") {
      if (bottom == "Milligrams") {
        ans = answer * 28349.5;
      } else if (bottom == "Grams") {
        ans = answer * 28.35;
      } else if (bottom == "Kilograms") {
        ans = answer / 35.274;
      } else if (bottom == "Pounds") {
        ans = answer / 16.0;
      } else if (bottom == "Stone") {
        ans = answer / 224.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Pounds") {
      if (bottom == "Milligrams") {
        ans = answer * 453592.0;
      } else if (bottom == "Grams") {
        ans = answer * 454.0;
      } else if (bottom == "Ounces") {
        ans = answer / 16.0;
      } else if (bottom == "Kilograms") {
        ans = answer / 2.205;
      } else if (bottom == "Stone") {
        ans = answer / 14.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Stone") {
      if (bottom == "Milligrams") {
        ans = answer * 6350293.2;
      } else if (bottom == "Grams") {
        ans = answer * 6350.0;
      } else if (bottom == "Ounces") {
        ans = answer * 224.0;
      } else if (bottom == "Pounds") {
        ans = answer * 14.0;
      } else if (bottom == "Kilograms") {
        ans = answer * 6.35;
      } else {
        ans = answer.toDouble();
      }
    }
    ans = double.parse((ans).toStringAsFixed(4));
    String a = ans.toString();
    return a;
  }
}
