import 'package:flutter/material.dart';

/// 各式各样的Sliver列表，走进Sliver世界，在Sliver世界里，所有组件都以Sliver开头，
/// 当你想要使用某种组件时，可以输入Sliver..查看

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sliver Lists"),
      ),
      body: CustomScrollView(
        slivers: [
          // -- SliverList 类似于 ListView
          // -- SliverFixedExtentList(delegate: delegate, itemExtent: itemExtent) // 类似于ListView + extent...
          // -- SliverPrototypeExtentList(delegate: delegate, prototypeItem: prototypeItem)
          // -- SliverFillViewport(delegate: delegate) // 类似于PageView
          SliverList(
            // -- SliverChildListDelegate：固定个数
            // -- SliverChildBuilderDelegate：动态加载
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 50,
                  color: Colors.primaries[index % 18],
                );
              },
              childCount: 8,
            ),
          ),

          // -- SliverGrid 类似于 GridView
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 50,
                  color: Colors.primaries[index % 18],
                );
              },
              childCount: 24,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
          )
        ],
      ),
    );
  }
}
