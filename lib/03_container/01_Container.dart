import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Container"),
        elevation: 0,
      ),
      body: const ContainerDemo(),
    );
  }
}

/// 1. Container 有child匹配尺寸，没有child越大越好。
/// 2. Container 实际上是组合
/// 2. width,height：SizeBox（尺寸） - 影响约束
/// 3. alignment：Align（对齐） - 影响约束
/// 4. padding：Padding（内补） - 影响约束

/// Placeholder

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 400,
      height: 400,
      alignment: Alignment.center,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        debugPrint("Container1 constraints：$constraints");
        return Container(
          color: Colors.orange,
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              debugPrint("Container2 constraints：$constraints");
              return const FlutterLogo(size: 100);
            },
          ),
        );
      }),
    );
  }
}
