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
  final List<Color> _colors = [
    Colors.blue.shade100,
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade500,
    Colors.blue.shade600,
    Colors.blue.shade700,
    Colors.blue.shade800,
  ];

  late int _slot;

  _shuffle() {
    setState(() {
      // 打乱顺序
      _colors.shuffle();
    });
  }

  _checkWinCondition() {
    // -- computeLuminance 计算颜色亮度
    // print(_colors.map((c) => c.computeLuminance()).toList());
    List<double> lum = _colors.map((c) => c.computeLuminance()).toList();
    bool success = true;
    for (int i = 0; i < lum.length - 1; i++) {
      if (lum[i] > lum[i + 1]) {
        success = false;
        break;
      }
    }
    debugPrint(success ? "win" : "");
  }

  final _globalKey = GlobalKey();
  double _offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 占据了一定的空间，导致在纵轴拖拽时，不能以0判断第一个位置，
      // 所以我们可以使用 Global 来处理
      appBar: AppBar(
        title: const Text("Color Games"),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: _shuffle, icon: const Icon(Icons.refresh))],
      ),
      // Listener：监听者（事件）
      body: Center(
        child: Column(children: [
          const SizedBox(height: 32),
          const Text("Welcome:", style: TextStyle(fontSize: 32)),
          const SizedBox(height: 32),
          Container(
            width: Box.width - Box.margin * 2,
            height: Box.height - Box.margin * 2,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: Box.margin * 2),
          Expanded(
            child: Listener(
              onPointerMove: (event) {
                final y = event.position.dy - _offset;
                debugPrint("y：$y");

                if (y > (_slot + 1) * Box.height) {
                  // -- 向右拖拽
                  // -- 如果移位到最后一个，则不需要再处理
                  if (_slot == _colors.length - 1) return;
                  setState(() {
                    final t = _colors[_slot];
                    _colors[_slot] = _colors[_slot + 1];
                    _colors[_slot + 1] = t;
                    _slot++;
                  });
                } else if (y < _slot * Box.height) {
                  // -- 向左拖拽
                  // -- 如果移位到第一个，则不需要再处理
                  if (_slot == 0) return;
                  setState(() {
                    final t = _colors[_slot];
                    _colors[_slot] = _colors[_slot - 1];
                    _colors[_slot - 1] = t;
                    _slot--;
                  });
                }
              },
              child: SizedBox(
                width: Box.width,
                child: Stack(
                  key: _globalKey,
                  children: List.generate(_colors.length, (i) {
                    return Box(
                      color: _colors[i],
                      x: 0,
                      y: i * Box.height,
                      key: ValueKey(_colors[i]),
                      onDrag: (Color color) {
                        final index = _colors.indexOf(color);
                        // -- 获取appBar的高度
                        final renderBox = _globalKey.currentContext?.findRenderObject() as RenderBox;
                        // localToGlobal 位置
                        _offset = renderBox.localToGlobal(Offset.zero).dy;
                        debugPrint("on drag $index. offset = $_offset");
                        _slot = index;
                      },
                      onEnd: _checkWinCondition,
                    );
                  }),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.color,
    required this.onDrag,
    required this.onEnd,
    required this.x,
    required this.y,
  }) : super(key: key);

  final Color color;
  final double x, y;
  final Function(Color) onDrag;
  final Function() onEnd;
  static const width = 100.0;
  static const height = 50.0;
  static const margin = 2.0;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width - margin * 2,
      height: height - margin * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: y,
      left: x,
      child: Draggable(
          onDragStarted: () => onDrag(color),
          onDragEnd: (_) => onEnd(),
          feedback: container,
          // Visibility：元素显示方式
          childWhenDragging: Visibility(
            visible: false,
            child: container,
          ),
          child: container),
    );
  }
}
