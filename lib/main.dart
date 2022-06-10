import 'package:flutter/material.dart';

// import 'package:flutter_examples/02_basic/01_Core.dart';
// import 'package:flutter_examples/02_basic/02_LayoutBuilder.dart';
import 'package:flutter_examples/02_basic/03_Text.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage()
    );
  }
}

