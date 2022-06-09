import 'package:flutter/material.dart';


// import 'package:flutter_examples/02_layouts/01_core/layout_core.dart';
// import 'package:flutter_examples/02_layouts/01_core/layout_builder.dart';
// import 'package:flutter_examples/02_layouts/01_core/layout_flex.dart';
import 'package:flutter_examples/02_layouts/01_core/layout_stack.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}

