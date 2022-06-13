/// 颜色排序小游戏

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
/*
class _HomePageState extends State<HomePage> {
  final boxes = [
    Box(color: Colors.blue.shade100, key: UniqueKey()),
    Box(color: Colors.blue.shade300, key: UniqueKey()),
    Box(color: Colors.blue.shade500, key: UniqueKey()),
    Box(color: Colors.blue.shade700, key: UniqueKey()),
    Box(color: Colors.blue.shade900, key: UniqueKey()),
  ];

  _shuffle() {
    setState(() {
      // 打乱顺序
      boxes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color Games"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        // -- ReorderableListView：可拖拽视图容器，必须要长按
        child: ReorderableListView(
          scrollDirection: Axis.vertical,
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) {
              //  向下移动
              newIndex--;
            }
            debugPrint("moved $oldIndex to $newIndex.");
            // 移除旧位置的数据
            final box = boxes.removeAt(oldIndex);
            // 将旧位置的数据插入到新的位置
            boxes.insert(newIndex, box);
          },
          children: boxes,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        child: const Icon(Icons.add),
      ),
    );
  }
}
class Box extends StatelessWidget {
  const Box({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      debugPrint('constraints:$constraints');
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        color: color,
      );
    });
  }
}

*/

/// 自定义 ReorderableListView 效果
class _HomePageState extends State<HomePage> {
  final boxes = [
    Box(color: Colors.blue.shade100, key: UniqueKey()),
    Box(color: Colors.blue.shade300, key: UniqueKey()),
    Box(color: Colors.blue.shade500, key: UniqueKey()),
    Box(color: Colors.blue.shade700, key: UniqueKey()),
    Box(color: Colors.blue.shade900, key: UniqueKey()),
  ];

  _shuffle() {
    setState(() {
      // 打乱顺序
      boxes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Color Games"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: boxes,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        debugPrint('constraints:$constraints');
        return Draggable(
          feedback: Container(
            margin: const EdgeInsets.all(8.0),
            width: 50,
            height: 50,
            color: color,
          ),
          childWhenDragging: Container(
            margin: const EdgeInsets.all(8.0),
            width: 50,
            height: 50,
            // color: color,
          ),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 50,
            height: 50,
            color: color,
          ),
        );
      },
    );
  }
}
