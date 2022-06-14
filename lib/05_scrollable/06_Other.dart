import 'package:flutter/material.dart';

/// 示例1：ListWheelScrollView，可实现拾取器的效果
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("其他组件"),
      ),
      body: ListWheelScrollView(
        // 高度
        itemExtent: 100,
        // 轴心偏移（正数向左，负数向右）
        offAxisFraction: 0,
        // 直径比例，默认2.0
        diameterRatio: 1.2,
        // 设置除正中间以外（上方和下方）元素的透明度
        overAndUnderCenterOpacity: 0.5,
        // 放大中间的元素
        magnification: 1.5,
        // 滚动物理
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => print("selected $index"),
        children: List.generate(
          100,
          (index) => Container(
            alignment: Alignment.center,
            color: Colors.blue,
            child: Text("$index"),
          ),
        ),
      ),
    );
  }
}*/

/// 示例2：PageView
/// 默认情况下：PageView是横向滑动的
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView"),
      ),
      body: PageView(
        // 滑动到指定位置停下来
        // pageSnapping: false,
        // 滚动方向
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) => print("selected $index"),
        children: [Container(color: Colors.blue), Container(color: Colors.orange)],
      ),
    );
  }
}*/

// 示例3：ReorderableListView - 可拖拽调整顺序
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReorderableListView"),
      ),
      body: ReorderableListView(
        header: Container(
          height: 50,
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text(
            "Header",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        onReorder: (int oldIndex, int newIndex) {
          print("moved from $oldIndex to $newIndex.");
        },
        children: List.generate(
          20,
          (index) => Text(
            "index is $index.",
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}*/

// 示例4：SingleChildScrollView 不建议使用，一般用在可能不滚动，但在阶段情况下（比如有些设备很小）使用
// 如个人中心这种，超出内容不是很多的情况下可使用。
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ReorderableListView"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            FlutterLogo(
              size: 500,
            ),
            FlutterLogo(
              size: 400,
            )
          ],
        ),
      ),
    );
  }
}
