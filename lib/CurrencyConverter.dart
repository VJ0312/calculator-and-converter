import 'package:calculator/Calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'TemperatureConverter.dart';
import 'WeightConverter.dart';
import 'DistanceConverter.dart';
import 'VolumeConverter.dart';
import 'package:http/http.dart' as http;
import 'PressureConverter.dart';

class CurrConvert extends StatefulWidget {
  @override
  _CurrConvert createState() => _CurrConvert();
}

class _CurrConvert extends State<CurrConvert> {
  String inputCurrency = "USD", outputCurrency = "CAD", result;
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();
  TextEditingController unitTextController = TextEditingController();
  List<String> currencies;


  void initState() { // At the very start, before build method is called, call _loadCurrencies()
    super.initState();
    _loadCurrencies();
  }

  Future<String> _loadCurrencies() async {
    String uri = "https://api.exchangeratesapi.io/latest";
    var response = await http.get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    return "";  // Access API for currency values
  }

  Future<String> _convert() async {
    String uri = "https://api.exchangeratesapi.io/latest?base=$inputCurrency&symbols=$outputCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(inputTextController.text) * (responseBody["rates"][outputCurrency])).toString();
      outputTextController.text = result != null ? result : "";
    });
    return ""; // take input currency and output currency
  }

  Future<String> _unitRate() async {
    String uri = "https://api.exchangeratesapi.io/latest?base=$inputCurrency&symbols=$outputCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse("1") * (responseBody["rates"][outputCurrency])).toString();
      unitTextController.text = result != null ? "1 $inputCurrency = $result $outputCurrency" : "";
    });
    return ""; // display unit rate for input currency
  }

  _inputCurrency(String value) {
    setState(() {
      inputCurrency = value;
    });
  }

  _outputCurrency(String value) {
    setState(() {
      outputCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currency Converter")), // Title at top
      drawer: drawerWidget(),
      body: currencies == null? CircularProgressIndicator() : Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                  padding: EdgeInsets.fromLTRB(0,20, 0, 0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            textBox(inputTextController),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                                  child: dropButton(inputCurrency),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(50,0,0,0),
                                  child: Text("TO", style: TextStyle(
                                    fontSize: 40,
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(50,0,0,0),
                                  child: dropButton(outputCurrency),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: TextField(
                                  controller: unitTextController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      size: 60,
                                    ),
                                    onPressed: () {
                                      _convert();
                                      _unitRate();
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: textBox(outputTextController),
                            ),
                          // outputTextBox(),
                          ],
                        ),
                      )
                  ),
                ),
              )),
    );
  }



  Widget textBox(var control) { // Create custom widget with parameters
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        style: TextStyle(
          fontSize: 30
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
        controller: control,
        keyboardType:
        TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget dropButton(String currCat) { // Create custom widget with parameters
    return DropdownButton(
      value: currCat,
      items: currencies
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        if (currCat == inputCurrency)
          _inputCurrency(value);
        else
          _outputCurrency(value);
      },
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
