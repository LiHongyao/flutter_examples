import 'package:flutter/material.dart';

/// Flutter 布局约束：老子说了算，即老子说啥就是啥，儿子必须服从老子的约束。

///  向下传递约束：设备 → 根组件 → 父组件 → 子组件，子组件必须满足父组件约束
///  即根组件必须满铺满整个屏幕，子级铺满父级元素，即使你设置了尺寸也无效，除非某个父级明确知道子级应该放在什么位置（松约束），子级设置的尺寸才有效，如center等。

///  向上传递尺寸：子组件 → 父组件 → 根组件
///  子级向父级传递尺寸，如果当子级没有铺满父级，而父级又不知道该如何放置子级时，子级传递的尺寸无效（如果父级是松约束，才生效）。

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("布局原理"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.orange,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.white,
            child: const Align(
              alignment: Alignment.center,
              child: FlutterLogo(size: 50),
            ),
          ),
        ),
      ),
    );
  }
}
