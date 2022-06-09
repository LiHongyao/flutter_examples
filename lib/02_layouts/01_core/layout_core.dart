import 'package:flutter/material.dart';

///  向下传递约束：即根组件必须铺满整个屏幕，子级铺满父级元素，即使你设置了尺寸也无效，除非某个父级明确子集应该放在什么位置，子集设置的尺寸才有效，如center
///  向上传递尺寸：子级向父级传递尺寸，如果当子级没有铺满父级，而父级又不知道该如何放置子级时，子级传递的尺寸无效。

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
