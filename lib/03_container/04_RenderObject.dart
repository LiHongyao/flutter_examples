import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RenderObject"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.orange[100],
        child: const RenderObjectDemo(),
      ),
    );
  }
}

class RenderObjectDemo extends StatelessWidget {
  const RenderObjectDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShadowBox(
      distance: 20,
      child: FlutterLogo(size: 200),
    );
  }
}

/// 自定义盒子阴影
/// SingleChildRenderObjectWidget 是真正能画到屏幕上的widget
class ShadowBox extends SingleChildRenderObjectWidget {
  final double distance;

  const ShadowBox({
    Key? key,
    required Widget child,
    this.distance = 4,
  }) : super(key: key, child: child);

  /// 改写createRenderObject，第一次create
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  /// 每次更新的时候需要告诉旧的renderObject如何去更新
  @override
  void updateRenderObject(BuildContext context, covariant RenderShadowBox renderObject) {
    renderObject.distance = distance;
  }
}

/*
class RenderShadowBox extends RenderBox with RenderObjectWithChildMixin {
  double distance;
  RenderShadowBox(this.distance);

  @override
  void performLayout() {
    child?.layout(constraints, parentUsesSize: true);
    // size = const Size(300, 300);
    size = (child as RenderBox).size;
  }

  /// 真正绘制，为所欲为，想画啥画啥
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    // -- 画child
    context.paintChild(child!, offset);
    // -- context.canvas
    // -- 透明阴影
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, offset + Offset(distance, distance));
    });
  }
}*/

/// 更简单的方式
/// 如果要实现溢出警告，需继承 with DebugOverflowIndicatorMixin
/// 并且实现方法 paintOverflowIndicator(context, offset, containerRect, childRect)
class RenderShadowBox extends RenderProxyBox {
  double distance;
  RenderShadowBox(this.distance);

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    // -- 画child
    context.paintChild(child!, offset);
    // -- context.canvas
    // -- 透明阴影
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, offset + Offset(distance, distance));
    });
  }
}
