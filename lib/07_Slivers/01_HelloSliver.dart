import 'package:flutter/material.dart';

/// Sliver 动机：
/// 1. 混搭列表
/// 2. 为了导航条

// Sliver 走进另一个世界，和常规的ListView，Column等普通组件不同
// 普通组件要想走进Sliver世界，需要使用视窗桥梁（CustomScrollView）
// Sliver组件都是以Sliver开头命名的，普通组件要想转成Sliver组件，可以通过 SliverToBoxAdapter/Sliverxxx 桥接，

/// 示例1：了解视窗
/*
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello, Sliver"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 450,
          child: ListView.builder(itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 200,
              color: Colors.primaries[index % 18],
            );
          }),
        ),
      ),
    );
  }
}*/

/// 示例2：CustomScrollView  -- 创建自定义视窗
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello, Sliver"),
      ),
      body: CustomScrollView(
        slivers: [
          // -- SliverToBoxAdapter：转接器，将普通的widget转成sliver
          const SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),
          const SliverToBoxAdapter(
            child: FlutterLogo(size: 100),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 200,
                  color: Colors.primaries[index % 18],
                );
              },
              childCount: 24,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 200,
                  color: Colors.primaries[index % 18],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
