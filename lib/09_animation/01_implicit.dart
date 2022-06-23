import "package:flutter/material.dart";

import 'animated_counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// -- 隐式动画（全自动）
// -- 动画组件以 Animated... 开头，只对当前Animated盒子属性变化时有效

/// 【示例1】：尝试修改下面的盒子属性，查看变化效果
/*class _HomePageState extends State<HomePage> {
  double _height = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: 300,
          height: _height,
          decoration: BoxDecoration(
            // color: _color,
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.2, 0.3]
              ),
              boxShadow: const [ BoxShadow(spreadRadius: 30, blurRadius: 25)],
              borderRadius: BorderRadius.circular(150)
          ),
          child: const Center(
            child: Text(
              "Hi",
              style: TextStyle(fontSize: 72),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _height = _height > 500 ? 200 : _height + 100;
            _color = _color == Colors.blue ? Colors.red : Colors.blue;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例2】 ：AnimatedSwitcher 组件切换动效
// -- 提示：如果组件一样，只更改内容，比如文本组件，则不会有动画效果
// -- 不过可以设置不同的key值让告诉Flutter这不是同一个组件，让动画出现
// -- AnimatedSwitcher 默认的动画效果是 FadeTransition（淡入淡出）
// -- 我们可以通过 transitionBuilder 属性更改动画效果
/*class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: 300,
          height: 300,
          color: Colors.orange,
          child: AnimatedSwitcher(
            // -- 自定义动画效果
            transitionBuilder: (child, animation) {
              // -- 淡入淡出
              // return FadeTransition(opacity: animation, child: child);
              // -- 旋转
              // return RotationTransition(turns: animation, child: child);
              return FadeTransition(
                opacity: animation,
                // -- 缩放
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            duration: const Duration(seconds: 2),
            child: Text(
              "Good",
              key: UniqueKey(),
              style: const TextStyle(fontSize: 72),
            ),
            // child: const Center(child:CircularProgressIndicator())
            // child: Image.network("https://t7.baidu.com/it/u=796860167,2432783067&fm=193&f=GIF"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例3】：更多动画控件及曲线（线性规律）

// -- 其他组件
// -- AnimatedOpacity：不透明度

// -- 线性规律：Curves.xxx
// -- 官网API：https://api.flutter.dev/flutter/animation/Curves-class.html

/*class _HomePageState extends State<HomePage> {
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: AnimatedPadding(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          padding: EdgeInsets.only(top: _top),
          child: Container(
            width: 300,
            height: 300,
            color: Colors.orange,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _top = 300;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例4】：补间动画 - TweenAnimationBuilder

/*class _HomePageState extends State<HomePage> {

  bool _isBig = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 1),
          // -- begin 只在最开始的会出现动画效果，后续可以通过修改end值实现动画
          // -- begin 值可以省略
          tween: Tween<double>(begin: 72, end: _isBig ? 172 : 72), // 设置起始帧，也可以用于字体大小
          builder: (BuildContext context, Object? value, Widget? child) {
            // -- 这里的value就是 tween 里面的值（起始帧 - 结束帧）
            // -- Transform.scale // 缩放
            // -- Transform.rotate
            // -- Transform.translate
            return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Hi",
                  style: TextStyle(fontSize: value as double),
                ),
              ),
            );
            // return Opacity(
            //   opacity: value as double,
            //   child: Container(
            //     width: 300,
            //     height: 300,
            //     color: Colors.orange,
            //   ),
            // );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isBig = !_isBig;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例5】：实战I - 翻滚吧！计数器！

/*class _HomePageState extends State<HomePage> {
  double _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          color: Colors.blue,
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: Tween<double>(end: _counter),
            builder: (BuildContext context, Object? value, Widget? child) {
              final whole = (value as double) ~/ 1; // 获得整数部分
              final decimal = value - whole; // 获得小数部分
              print("$whole + $decimal");
              debugPrint(value.toString());
              return Stack(
                children: [
                  Positioned(
                    top: -100 * decimal, // 0 → - 100
                    child: Opacity(
                      opacity: 1.0 - decimal, // 1 → 0
                      child: Text(
                        "$whole",
                        style: const TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100 - decimal * 100, // 100 → 0
                    child: Opacity(
                      opacity: decimal, // 0 → 1
                      child: Text(
                        "${whole + 1}",
                        style: const TextStyle(fontSize: 100),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter += 10;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例6】：封装Counter组件
class _HomePageState extends State<HomePage> {
  double _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐式动画"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          color: Colors.blue,
          child: AnimatedCounter(
            value: _counter.toInt(),
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter += 10;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
