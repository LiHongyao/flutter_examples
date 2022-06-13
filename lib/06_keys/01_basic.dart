/// 【知识点1】
/// StatefulWidget：Widget Tree（蓝图） / Element Tree（对象 -- State），二者是分开的，Flutter

/// Flutter 在更新时，会根据【类型】和【key】值判断是否更新 Element Tree（类似前端key值作用）
/// 在没有设置key的情况下，调整box的位置，只会更新 Widget Tree，状态不会跟着变，因为在Flutter看来，
/// 三个Box类型和key都一致（因为没有设置key），只是样式变化了，所以就不会去更新对应的State了，
/// 要想在调整顺序后，颜色和状态跟着变，我们只需要给Box指定key值即可。

/// 提示：
/// 1. Flutter只会在同级根据key去查找/比较/更新
/// 2. 无状态组件无需使用key

///【知识点2】
/// 1. key的类型
/// -- Local Key（局部键/同级唯一）
/// -- Global Key（全局键/全局唯一/性能上来讲，尽量不用全局键）

/// 2. 局部键的创建方式
/// -- ValueKe/对比值
/// -- ObjectKey/对比实例（instance，指针)
/// -- UniqueKey/唯一键，类似于Symbol，缺点是无法保留状态，放弃节点复用（因为每次都会重新生成，不过你可以定义在build外部，程序只会初始化一次），常用于动画

/// 3. 全局键的创建方式
/// -- GlobalKey()
/// -- 两种用法：设置唯一键；查找元素（如：_globalKey.currentState,_globalKey.currentWidget,_globalKey.currentContext）；

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keys"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // ValueKey：生产key值
            Box(color: Colors.orange, key: ValueKey(3)),
            Box(color: Colors.pink, key: ValueKey(2)),
            Box(color: Colors.red, key: ValueKey(1)),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  const Box({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: widget.color,
      child: Center(
        child: ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: Text("$_count", style: const TextStyle(fontSize: 50)),
        ),
      ),
    );
  }
}
