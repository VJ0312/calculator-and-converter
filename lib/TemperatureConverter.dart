import 'package:calculator/WeightConverter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/CurrencyConverter.dart';
import 'SimpleCalculator.dart';
import 'DistanceConverter.dart';
import 'package:calculator/VolumeConverter.dart';

class TemperatureConvert extends StatefulWidget {
  _TemperatureConvert createState() => _TemperatureConvert();
}

// same as Distance Convert and Weight Convert

class _TemperatureConvert extends State<TemperatureConvert> {

  var tempDropDownValue = "Celsius", tempDropDown = "Fahrenheit", inputValue;
  final textC = TextEditingController();
  final textC2 = TextEditingController();
  var convertedResult;

  _onFromChanged(String value) {
    setState(() {
      tempDropDownValue = value;
      print("tempDropDownValue $tempDropDownValue");
    });
  }

  _onToChanged(String value) {
    setState(() {
      tempDropDown = value;
      print("tempDropDown $tempDropDown");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Temperature Converter")),
        drawer:  drawerWidget(),
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
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                                hintText:
                                "Enter a value in $tempDropDownValue"),
                          ),
                          trailing:
                          tempDropDownBut(tempDropDownValue)),
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
                                  tempDropDownValue,
                                  tempDropDown);
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
                                hintText: "conversion in $tempDropDown"),
                          ),
                          trailing: tempDropDownBut(tempDropDown)),
                    )
                  ],
                ),
              )
          ),
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
        ],
      ),
    );
  }

  Widget tempDropDownBut(String disValue) {
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
        'Celsius',
        'Fahrenheit',
        'Kelvins',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          if (disValue == tempDropDownValue) {
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
    if (top == "Celsius") {
      if (bottom == "Fahrenheit") {
        ans = (answer * 1.8) + 32.0;
      } else if (bottom == "Kelvins") {
        ans = answer + 273.15;
      }
       else {
        ans = answer.toDouble();
      }
    } else if (top == "Fahrenheit") {
      if (bottom == "Celsius") {
        ans = (answer - 32.0) / 1.80;
      } else if (bottom == "Kelvins") {
        ans = (answer + 459.67) * 5 / 9;
      }
      else {
        ans = answer.toDouble();
      }
    }
    else {
      if (bottom == "Celsius") {
        ans = answer - 273.15;
      } else if (bottom == "Fahrenheit") {
        ans = 1.8 * (answer - 273) + 32;
      }
     else {
        ans = answer.toDouble();
      }
    }
    ans = double.parse((ans).toStringAsFixed(4));
    String a = ans.toString();
    return a;
  }
}
