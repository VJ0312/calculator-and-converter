import 'package:calculator/WeightConverter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/CurrencyConverter.dart';
import 'SimpleCalculator.dart';
import 'DistanceConverter.dart';

class VolumeConvert extends StatefulWidget {
  _VolumeConvert createState() => _VolumeConvert();
}

// same as Distance Convert and Weight Convert

class _VolumeConvert extends State<VolumeConvert> {

  var volumeDropDownValue = "Litres", volumeDropDown = "Millilitres", inputValue;
  final textC = TextEditingController();
  final textC2 = TextEditingController();
  var convertedResult;

  _onFromChanged(String value) {
    setState(() {
      volumeDropDownValue = value;
      print("volumeDropDownValue $volumeDropDownValue");
    });
  }

  _onToChanged(String value) {
    setState(() {
      volumeDropDown = value;
      print("volumeDropDown $volumeDropDown");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Volume Converter")),
        drawer:  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title: Text('Calculator', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimpleCalculator()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                  Text('Distance Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DistanceConvert()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title:
                  Text('Currency Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CurrConvert()));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ListTile(
                  title: Text('Weight Conversion', style: TextStyle(fontSize: 30)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WeightConvert()));
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
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    hintText:
                                    "Enter a value in $volumeDropDownValue"),
                              ),
                              trailing:
                              volumeDropDownBut(volumeDropDownValue)),
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
                                      volumeDropDownValue,
                                      volumeDropDown);
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
                                    hintText: "conversion in $volumeDropDown"),
                              ),
                              trailing: volumeDropDownBut(volumeDropDown)),
                        )
                      ],
                    ),
                  )
              ),
            ) //: null,
        );
  }
  Widget volumeDropDownBut(String disValue) {
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
        'Millilitres',
        'Litres',
        'Kilolitres',
        'Fluid Ounces',
        'Pints',
        'Gallons',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          if (disValue == volumeDropDownValue) {
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
    if (top == "Millilitres") {
      if (bottom == "Litres") {
        ans = answer / 1000.0;
      } else if (bottom == "Kilolitres") {
        ans = answer / 1000000.0;
      } else if (bottom == "Fluid Ounces") {
        ans = answer / 29.574;
      } else if (bottom == "Pints") {
        ans = answer / 473.0;
      } else if (bottom == "Gallons") {
        ans = answer / 3785.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Litres") {
      if (bottom == "Millilitres") {
        ans = answer * 1000.0;
      } else if (bottom == "Kilolitres") {
        ans = answer / 1000.0;
      } else if (bottom == "Fluid Ounces") {
        ans = answer * 33.814;
      } else if (bottom == "Pints") {
        ans = answer / 2.113;
      } else if (bottom == "Gallons") {
        ans = answer /  3.785411784;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Kilolitres") {
      if (bottom == "Millilitres") {
        ans = answer * 1000000.0;
      } else if (bottom == "Litres") {
        ans = answer * 1000.0;
      } else if (bottom == "Fluid Ounces") {
        ans = answer * 33814.0;
      } else if (bottom == "Pints") {
        ans = answer * 2113.0;
      } else if (bottom == "Gallons") {
        ans = answer * 264.172;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Fluid Ounces") {
      if (bottom == "Millilitres") {
        ans = answer * 29.574;
      } else if (bottom == "Kilolitres") {
        ans = answer /  33814.0;
      } else if (bottom == "Litres") {
        ans = answer / 33.814;
      } else if (bottom == "Pints") {
        ans = answer / 16;
      } else if (bottom == "Gallons") {
        ans = answer /  128.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Pints") {
      if (bottom == "Millilitres") {
        ans = answer * 473.176;
      } else if (bottom == "Kilolitres") {
        ans = answer / 473.176;
      } else if (bottom == "Fluid Ounces") {
        ans = answer * 16.0;
      } else if (bottom == "Litres") {
        ans = answer / 2.113;
      } else if (bottom == "Gallons") {
        ans = answer /  8.0;
      } else {
        ans = answer.toDouble();
      }
    } else if (top == "Gallons") {
      if (bottom == "Millilitres") {
        ans = answer * 3785.0;
      } else if (bottom == "Kilolitres") {
        ans = answer / 264.0;
      } else if (bottom == "Fluid Ounces") {
        ans = answer * 128.0;
      } else if (bottom == "Pints") {
        ans = answer * 6.661;
      } else if (bottom == "Litres") {
        ans = answer / 3.785;
      } else {
        ans = answer.toDouble();
      }
    }
    ans = double.parse((ans).toStringAsFixed(4));
    String a = ans.toString();
    return a;
  }
}
