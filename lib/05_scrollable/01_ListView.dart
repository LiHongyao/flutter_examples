import 'package:flutter/material.dart';

/// 示例1
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滚动列表与动态加载"),
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: 88,
        // cacheExtent: 3, // 设置缓冲范围（了解，默认即可）
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const Divider(thickness: 4, color: Colors.redAccent);
          }
          return Divider(
            thickness: 1,
            color: Colors.blue[200],
          );
        },
        itemBuilder: (BuildContext context, int index) {
          debugPrint("building $index...");
          return Container(
            height: 100,
            alignment: Alignment.center,
            child: Text("$index"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

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
        title: GestureDetector(
          onTap: () {
            if (_controller.hasClients && _controller.offset > 0) {
              _controller.animateTo(-20, duration: const Duration(seconds: 1), curve: Curves.linear);
            }
          },
          child: const Text("ListView demo"),
        ),
      ),
      body: false
          ? const Center(
              child: Text("Nothing's in here."),
            )
          : Scrollbar(
              controller: _controller,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint(_controller.offset.toString());
          _controller.animateTo(_controller.offset + 200.0,
              duration:  const Duration(milliseconds: 500), curve: Curves.linear);
        },
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
