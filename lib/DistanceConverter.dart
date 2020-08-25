import 'package:calculator/SimpleCalculator.dart';
import 'package:calculator/VolumeConverter.dart';
import 'package:calculator/WeightConverter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/CurrencyConverter.dart';

class DistanceConvert extends StatefulWidget {
  _DistanceConvert createState() => _DistanceConvert();
}

class _DistanceConvert extends State<DistanceConvert> { // Initialize Variables
  var dropDownValue = "Inches", dropDown = "Feet", inputValue;
  TextEditingController textC = TextEditingController();
  TextEditingController textC2 = TextEditingController();
  var convertedResult;

  _onFromChanged(String value) {
    setState(() {
      dropDownValue = value;
      print("dropDownValue $dropDownValue");
    });
  }

  _onToChanged(String value) {
    setState(() {
      dropDown = value;
      print("dropDown $dropDown");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Distance Converter")),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                      Text('Calculator', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimpleCalculator(), // when "Calculator" is pressed, switch screen to Calculator screen
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CurrConvert())); // when "Currency Conversion" is pressed, switch screen to Currency conversion screen
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                      Text('Weight Conversion', style: TextStyle(fontSize: 30)), // when "Weight Conversion" is pressed, switch screen to Weight conversion screen
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeightConvert()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                      Text('Volume Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VolumeConvert()));
                    // when "Volume Conversion" is pressed, switch screen to volume conversion screen
                  },
                ),
              )
            ],
          ),
        ),
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
                                hintText: "Enter a value in $dropDownValue"),
                          ),
                          trailing: DistancedropdownBut(dropDownValue)),
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
                              textC2.text = MetricConversionTools()
                                  .convert(inputValue, dropDownValue, dropDown); // pass in 3 variables to class MetricConversionTools() for conversion
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
                                hintText: "conversion in $dropDown"),
                          ),
                          trailing: DistancedropdownBut(dropDown)),
                      // Call custom widget
                    )
                  ],
                ),
              )),
        ) //: null,

        );
  }

  Widget DistancedropdownBut(String disValue) { // create custom widget
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
      items: <String>[ // assign dropdown values
        'Inches',
        'Feet',
        'Yards',
        'Miles',
        'Centimetres',
        'Metres',
        'Kilometres',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          if (disValue == dropDownValue) {
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

class MetricConversionTools { // initialize class
  String convert(var input, var top, var bottom) {
    var answer = int.parse(input);
    double ans;
    if (top == "Inches") {
      if (bottom == "Feet") {
        ans = answer / 12.0;
      } else if (bottom == "Yards") {
        ans = answer / 36.0;
      } else if (bottom == "Miles") {
        ans = answer / 63360.0;
      } else if (bottom == "Centimetres") {
        ans = answer * 2.54;
      } else if (bottom == "Metres") {
        ans = answer / 39.37;
      } else if (bottom == "Kilometres") {
        ans = answer / 39370.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Feet") {
      if (bottom == "Inches") {
        ans = answer / 12.0;
      } else if (bottom == "Yards") {
        ans = answer / 3.0;
      } else if (bottom == "Miles") {
        ans = answer / 5280.0;
      } else if (bottom == "Centimetres") {
        ans = answer * 30.48;
      } else if (bottom == "Metres") {
        ans = answer / 3.281;
      } else if (bottom == "Kilometres") {
        ans = answer / 3281.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Yards") {
      if (bottom == "Inches") {
        ans = answer / 36.0;
      } else if (bottom == "Feet") {
        ans = answer * 3.0;
      } else if (bottom == "Miles") {
        ans = answer / 1760;
      } else if (bottom == "Centimetres") {
        ans = answer * 91.44;
      } else if (bottom == "Metres") {
        ans = answer / 1.094;
      } else if (bottom == "Kilometres") {
        ans = answer / 1094.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Miles") {
      if (bottom == "Inches") {
        ans = answer * 63360.0;
      } else if (bottom == "Feet") {
        ans = answer * 5280.0;
      } else if (bottom == "Yards") {
        ans = answer * 1760.0;
      } else if (bottom == "Centimetres") {
        ans = answer * 160934.0;
      } else if (bottom == "Metres") {
        ans = answer * 1609.34;
      } else if (bottom == "Kilometres") {
        ans = answer * 1.60934;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Centimetres") {
      if (bottom == "Inches") {
        ans = answer / 2.54;
      } else if (bottom == "Feet") {
        ans = answer / 30.48;
      } else if (bottom == "Yards") {
        ans = answer / 91.44;
      } else if (bottom == "Miles") {
        ans = answer / 160934;
      } else if (bottom == "Metres") {
        ans = answer / 100;
      } else if (bottom == "Kilometres") {
        ans = answer / 100000.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Metres") {
      if (bottom == "Inches") {
        ans = answer / 39.37;
      } else if (bottom == "Feet") {
        ans = answer * 3.28;
      } else if (bottom == "Yards") {
        ans = answer * 1.094;
      } else if (bottom == "Miles") {
        ans = answer / 1609.0;
      } else if (bottom == "Centimetres") {
        ans = answer * 100.0;
      } else if (bottom == "Kilometres") {
        ans = answer / 1000;
      } else {
        ans = answer.toDouble();
      }
    } else {
      if (bottom == "Inches") {
        ans = answer * 39370.0;
      } else if (bottom == "Feet") {
        ans = answer * 3281.0;
      } else if (bottom == "Yards") {
        ans = answer * 1094.0;
      } else if (bottom == "Miles") {
        ans = answer / 1.609;
      } else if (bottom == "Centimetres") {
        ans = answer * 100000.0;
      } else if (bottom == "Metres") {
        ans = answer * 1000.0;
      } else {
        ans = answer.toDouble();
      }
    }
    ans = double.parse((ans).toStringAsFixed(4));
    String a = ans.toString(); // return answer accurate to 4 decimal places
    return a;
  }
}
