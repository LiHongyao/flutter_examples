import 'package:flutter/material.dart';

// import 'package:flutter_examples/02_basic/01_Core.dart';
// import 'package:flutter_examples/02_basic/02_LayoutBuilder.dart';
// import 'package:flutter_examples/02_basic/03_Text.dart';

// import 'package:flutter_examples/03_container/01_Container.dart';
// import 'package:flutter_examples/03_container/03_CustomMultiChildLayout.dart';
// import 'package:flutter_examples/03_container/04_RenderObject.dart';

// import 'package:flutter_examples/05_scrollable/01_ListView.dart';
// import 'package:flutter_examples/05_scrollable/02_Refresh.dart';
// import 'package:flutter_examples/05_scrollable/03_Dismissible.dart';
// import 'package:flutter_examples/05_scrollable/04_Examples.dart';
// import 'package:flutter_examples/05_scrollable/05_GridView.dart';
// import 'package:flutter_examples/05_scrollable/06_Other.dart';

// import 'package:flutter_examples/06_keys/01_basic.dart';
// import 'package:flutter_examples/06_keys/02_color_game.dart';

// import 'package:flutter_examples/07_Slivers/01_HelloSliver.dart';
// import 'package:flutter_examples/07_Slivers/02_SliverList.dart';
// import "package:flutter_examples/07_Slivers/03_SliverAppBar.dart";
// import 'package:flutter_examples/07_Slivers/04_MoreSliverWidget.dart';
// import 'package:flutter_examples/07_Slivers/05_ListViewToSliver.dart';

// import 'package:flutter_examples/08_Async/01_EventLoop.dart';
// import 'package:flutter_examples/08_Async/02_FutureBuilder.dart';
// import 'package:flutter_examples/08_Async/03_StreamBuilder.dart';


import 'package:flutter_examples/09_animation/01_implicit.dart';

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
      home: const HomePage(),
    );
  }
}
