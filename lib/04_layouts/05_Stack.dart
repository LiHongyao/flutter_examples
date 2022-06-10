import 'package:flutter/material.dart';

///  Stack 会先去计算没有位置（即没有被Positioned包裹）的组件，然后再把自己的尺寸调整为没有位置组件的最大尺寸，最后再来计算有位置的组件。
///  如果Stack所有的子组件都是有位置的，则Stack自身的尺寸为父级约束的尺寸（越大越好）
///  如果Stack所有的子组件都是没有位置的，则Stack自身的尺寸为子元素中最大尺寸的那一个的尺寸（越小越好）

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack"),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Colors.green[200],
          child: Stack(
            // fit: StackFit.loose, // 约束模式（对子元素起作用）
            alignment: Alignment.center,
            children: [
              const Text(
                "Hello, Stack",
                style: TextStyle(fontSize: 40),
              ),
              const FlutterLogo(size: 200),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
