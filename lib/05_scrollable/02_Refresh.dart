import 'package:flutter/material.dart';

/// 示例2
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Refresh"),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        // -- 样式
        strokeWidth: 2.0,
        color: Colors.white,
        backgroundColor: Colors.black,
        // -- 写法1
        onRefresh: () {
          debugPrint("__refresh__");
          // -- Future 类似于JS中的Promise，异步操作
          return Future.delayed(const Duration(seconds: 5));
        },
        // -- 写法2 -- 伪代码
        /*
        onRefresh: () async {
          await _loadData();
          setState((){});
        },*/
        child: Scrollbar(
          // 是否显示滚动条（总是，默认只有在滑动时才显示）
          thumbVisibility: true,
          // 控制器，和 ListView 一致
          controller: _controller,
          // -- ListView 滚动时，scroll事件通过冒泡机制传递给Scrollbar
          // -- 这里 NotificationListener 只是为了演示，实际开发中不需要写
          // -- 在onNotification方法中，返回true则不再冒泡，返回false继续冒泡
          child: NotificationListener(
            onNotification: (ScrollNotification event) {
              // print(event);
              return false;
            },
            child: ListView.builder(
              // 物理效果
              physics: const BouncingScrollPhysics(),
              // 技巧：设置底部的间距，可以处理悬浮按钮遮挡问题
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: 40,
              // 主轴尺寸，紧约束
              itemExtent: 60,
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                debugPrint("building $index...");
                return const ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Name"),
                  subtitle: Text("Subtitle"),
                  trailing: Icon(Icons.delete_outline),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
