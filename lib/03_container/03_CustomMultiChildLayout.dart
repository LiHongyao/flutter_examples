import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CustomMultiChildLayout"),
        elevation: 0,
      ),
      body: const CustomMultiChildLayoutDemo(),
    );
  }
}

/// 自定义布局

class CustomMultiChildLayoutDemo extends StatelessWidget {
  const CustomMultiChildLayoutDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: CustomMultiChildLayout(
        delegate: MyDelete(thickness: 20),
        children: [
          LayoutId(
            id: "underline",
            child: Container(
              color: Colors.red,
            ),
          ),
          LayoutId(
            id: "text",
            child: const Text(
              "Hello, Flutter!",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDelete extends MultiChildLayoutDelegate {
  final double thickness;
  MyDelete({this.thickness = 8.0});

  @override
  Size getSize(BoxConstraints constraints) {
    super.getSize(constraints);
    // -- 调整代码查看效果
    // return constraints.biggest;
    return const Size(300, 200);
  }

  @override
  // -- size：表示CustomMultiChildLayout自己的尺寸（约束）
  void performLayout(Size size) {
    print(size);
    late Size size1, size2;
    late double top;

    /// 布局id为text的child
    if (hasChild("text")) {
      size1 = layoutChild(
        "text",
        // === BoxConstraints.tight(const Size(100, 100)) - 100x100
        // === BoxConstraints.loose(const Size(100, 100)) - 0~100x0~100
        // === const BoxConstraints(minWidth: 100,minHeight: 100,maxWidth: 100,maxHeight: 100),
        BoxConstraints.loose(size),
      );
      //  定位child
      final left = (size.width - size1.width) / 2;
      top = (size.height - size1.height) / 2;
      positionChild("text", Offset(left, top));
    }

    /// 布局id为underline的child
    if (hasChild("underline")) {
      size2 = layoutChild("underline", BoxConstraints.tight(Size(size1.width, thickness)));
      //  定位child
      final left = (size.width - size2.width) / 2;
      positionChild("underline", Offset(left, top + size1.height));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
