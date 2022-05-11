import 'package:flutter/material.dart';
import 'package:flutter_naming_app/src/random_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RandomList()
    );
  }
}
