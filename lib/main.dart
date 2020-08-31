import 'package:flutter/material.dart';
import 'SimpleCalculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
     home: SimpleCalculator(), //load Calculator on start
  );
}
}

