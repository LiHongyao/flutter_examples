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
        title: const Text("侧滑删除"),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          // - 定制右滑效果
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: const Icon(Icons.phone),
          ),
          // - 定制左滑效果
          secondaryBackground: Container(
            color: Colors.black87,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            child: const Icon(
              Icons.sms,
              color: Colors.white,
            ),
          ),
          // -- 确认删除（true/false）
          confirmDismiss: (DismissDirection direction) async {
            return true;
          },
          // -- 设置滑动的距离，即滑动到指定位置可自动
          dismissThresholds: const {
            DismissDirection.startToEnd: 0.1,
            DismissDirection.endToStart: 0.99,
          },
          // -- 删除时的持续时间
          resizeDuration: const Duration(seconds: 3),
          // -- 拖拽松手回弹时的持续时间
          movementDuration: const Duration(seconds: 2),
          // -- 删除时的回调
          onResize: () {
            debugPrint('__onResize__');
          },
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              debugPrint("左滑");
            }
            if (direction == DismissDirection.startToEnd) {
              debugPrint("右滑");
            }
          },
          child: Container(
            height: 80,
            color: Colors.blue[index % 9 * 100],
          ),
        ),
      ),
    );
  }
}
