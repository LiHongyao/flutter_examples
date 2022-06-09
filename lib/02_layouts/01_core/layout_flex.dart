import 'package:flutter/material.dart';


/// Column 的尺寸取决于父级约束，及铺满父级
/// Column 在布局时，首先会去计算固定尺寸的组件，然后再将剩余空间分给 弹性组件（Expanded，Flexible）
/// 如果固定尺寸的组件加起来的尺寸大于了父级约束则会出现溢出的情况（程序报错）

/// 由于ListView 可以是无限高度，所以嵌套时会出现溢出的情况，显然会超出Column的约束
/// 这时我们可以在ListView外层包裹 Expanded，ListView超出部分将会滚动

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flex"),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Colors.green[200],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FlutterLogo(size: 50),
              Expanded(
                child: ListView(
                  children: [for (int i = 0; i < 100; i++) Text("Item $i")],
                ),
              ),
              const FlutterLogo(size: 50),
            ],
          ),
        ),
      ),
    );
  }
}
