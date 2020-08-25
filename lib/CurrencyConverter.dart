import 'package:calculator/DistanceConverter.dart';
import 'package:calculator/VolumeConverter.dart';
import 'package:calculator/WeightConverter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SimpleCalculator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrConvert extends StatefulWidget {
  @override
  _CurrConvert createState() => _CurrConvert();
}

class _CurrConvert extends State<CurrConvert> {
  String inputCurrency = "USD", outputCurrency = "CAD", result;
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();
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
                  child: Column(
                    children: <Widget>[
                      listFields(40, inputTextController, "Enter a value", inputCurrency), // call ListFields and give parameters
                      convertArrow(),
                      listFields(50, outputTextController, "", outputCurrency), // call ListFields and give parameters
                    ],
                  ),
                ),
              )),
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

  Widget drawerWidget() {  // Create custom widget with parameters
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title: Text('Calculator', style: TextStyle(fontSize: 30)),
              onTap: () {
                Navigator.push( // when "Calculator" is pressed, switch screen to Calculator screen
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
                    MaterialPageRoute(builder: (context) => DistanceConvert())); // when "Distance Conversion" is pressed, switch screen to distance conversion screen
              },
            ),
          ), Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: ListTile(
              title:
              Text('Weight Conversion', style: TextStyle(fontSize: 30)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WeightConvert())); // when "Weight Conversion" is pressed, switch screen to Weight conversion screen
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
                    MaterialPageRoute(builder: (context) => VolumeConvert())); // when "Volume Conversion" is pressed, switch screen to volume conversion screen
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listFields(double pad, var control, String text, var curr) {  // Create custom widget with parameters
    return Padding(
      padding: EdgeInsets.fromLTRB(0, pad, 0, 0),
      child: ListTile(
        title: TextField(
          controller: control,
          keyboardType:
          TextInputType.numberWithOptions(decimal: true),
          decoration:
          InputDecoration(hintText: text),
        ),
        trailing: dropButton(curr),
      ),
    );
  }

  Widget convertArrow() {  // Create custom widget with parameters
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_downward,
          size: 60,
        ),
        onPressed: _convert,
      ),
    );
  }
}
