import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滚动列表与动态加载"),
        elevation: 0,
      ),
      body: const ScrollAndDynamicLoad(),
    );
  }
}

/// 滚动列表

class ScrollAndDynamicLoad extends StatelessWidget {
  const ScrollAndDynamicLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 88,
      // cacheExtent: 3, // 设置缓冲范围（了解）
      itemBuilder: (BuildContext context, int index) {
        debugPrint("building $index...");
        return index % 2 == 0
            ? Divider(
                thickness: 1,
                color: Colors.blue[200],
              )
            : Container(
                height: 100,
                alignment: Alignment.center,
                child: Text("$index"),
              );
      },
    );
  }
}
