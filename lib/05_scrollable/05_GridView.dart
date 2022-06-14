import 'package:flutter/material.dart';

/// 示例1
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView"),
        elevation: 0,
      ),
      body: GridView.builder(
        // -- gridDelegate：
        // -- SliverGridDelegateWithFixedCrossAxisCount 固定列数，语法糖：GridView.count(crossAxisCount: crossAxisCount)
        // -- SliverGridDelegateWithMaxCrossAxisExtent 限定宽度，语法糖：GridView.extent(maxCrossAxisExtent: maxCrossAxisExtent)
        // -- 注意：如果使用语法糖写法，就不能实现懒加载了。
        // -- 如果你只是单纯的展示固定几个元素，推荐使用语法糖
        // -- 如果你需要动态加载，则使用builder + delegate
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // 交叉轴显示的个数，子元素宽度 = 容器宽度 / 4
          crossAxisCount: 4,
          // 设置宽高比例，
          childAspectRatio: 16 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blue[index % 8 * 100],
          );
        },
      ),
    );
  }
} */

/// 示例2
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        // 比例
        childAspectRatio: 16 / 9,
        // 主轴间距
        mainAxisSpacing: 3.0,
        // 交叉轴间距
        crossAxisSpacing: 4.0,
        padding: const EdgeInsets.all(10),
        children: [
          Container(color: Colors.blue, child: const Icon(Icons.title)),
          Container(color: Colors.blue, child: const Icon(Icons.person)),
          Container(color: Colors.blue, child: const Icon(Icons.print)),
          Container(color: Colors.blue, child: const Icon(Icons.branding_watermark)),
          Container(color: Colors.blue, child: const Icon(Icons.settings)),
          Container(color: Colors.blue, child: const Icon(Icons.home)),
        ],
      ),
    );
  }
}
