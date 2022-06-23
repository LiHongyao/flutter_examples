import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

/// 【示例1】：基础 了解动画动画控制器的基础使用
/*class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this, // 垂直同步，使用Flutter提供的 SingleTickerProviderStateMixin
    );
  }

  @override
  void dispose() {
    super.dispose();
    // -- 一定要记得释放动画控制器
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: const Icon(
            Icons.refresh,
            size: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.forward();  // 执行1次
          // _controller.repeat();   // 执行n次
          // _controller.reset();    // 重置停止
          // _controller.stop();     // 原地停止

          if (_loading) {
            _controller.repeat();
          } else {
            _controller.stop();
          }
          _loading = !_loading;
        },
        child: const Icon(Icons.start),
      ),
    );
  }
}*/

/// 【示例2】动画控制器到底是什么东西

// -- AnimationController 实际上就是一些列的double值
// -- 显示动画空间都是以 ...Transition 结尾，Flutter自带的显示动画组件如下：
// -- 1. RotationTransition 旋转
// -- 2. FadeTransition 不透明度
// -- 3. ScaleTransition 缩放...
// -- 4. SlideTransition 位移

// -- Flutter 技巧：输入sta可创建带动画控制器的组件

/*class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _controller.addListener(() {
      // value 默认值时0-1，可以通过 lowerBound - upperBound 控制气势帧
      debugPrint("${_controller.value}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        // -- RotationTransition
        // --
        child: ScaleTransition(
          scale: _controller,
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.repeat(reverse: true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例3】 控制器串联补间（Tween) 和 曲线（线性规律）
/*class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      // lowerBound: 0.0,
      // upperBound: 1.0,
    )..repeat();
    // -- .repeat() 不会回传 controller，我们可以+两个.（Flutter技巧）
    // -- 直接执行
    // _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        // -- ScaleTransition
        child: SlideTransition(
          // -- 使用Tween来控制起始帧
          position: Tween(begin: const Offset(0, -0.5), end: const Offset(0, 0.8))
              .chain(CurveTween(curve: Curves.elasticInOut))
              .animate(_controller),
          // -- 等价于下面注意一行代码，优势在于直观，并且可以通过chain链接多个Tween
          // position: _controller.drive(Tween(begin: const Offset(0, 0), end: const Offset(0.5, 0))),

          // scale: _controller.drive(Tween(begin: 0.5, end: 2.0)),
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.stop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例4】：交错动画

/*class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlidingBox(
              controller: _controller,
              color: Colors.blue.shade100,
              interval: const Interval(0.0, 0.2),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue.shade300,
              interval: const Interval(0.2, 0.4),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue.shade500,
              interval: const Interval(0.4, 0.6),
            ),
            // ScaleTransition(
            //   scale: Tween(begin: 1.0, end: 1.5)
            //       .chain(CurveTween(curve: const Interval(0.4, 0.6)))
            //       .animate(_controller),
            //   child: Container(
            //     width: 300,
            //     height: 100,
            //     color: Colors.blue.shade500,
            //   ),
            // ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue.shade700,
              interval: const Interval(0.6, 0.8),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue.shade900,
              interval: const Interval(0.8, 1.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SlidingBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;
  const SlidingBox({
    Key? key,
    required this.controller,
    required this.color,
    required this.interval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: const Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(controller),
      child: Container(width: 300, height: 100, color: color),
    );
  }
}*/

/// 【示例5】自定义动画
/*class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation heightAnimation = Tween(begin: 100.0, end: 150.0).animate(_controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: const Center(
            child: Text(
              "Hi",
              style: TextStyle(fontSize: 72),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            // -- child：用于优化，将设置的child返回给我们
            // -- 我们通常可以把没有参与的元素动画传过来设置
            return Opacity(
              opacity: _controller.value,
              child: Container(
                width: 300,
                height: heightAnimation.value, // 和下面两种方式效果一致
                // height: Tween(begin: 100.0, end: 200.0).evaluate(_controller),
                // height: 200 + 100 * _controller.value,
                color: Colors.blue,
                child: child,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}*/

/// 【示例6】 案例：478呼吸法动画
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final _expansionController = AnimationController(vsync: this);
  late final _opacityController = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _expansionController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Animation animation1 = Tween(begin: 0.0, end: 1.0)
    //     .chain(CurveTween(curve: const Interval(0.0, 0.2)))
    //     .animate(_controller);
    // Animation animation3 = Tween(begin: 1.0, end: 0.0)
    //     .chain(CurveTween(curve: const Interval(0.4, 0.95)))
    //     .animate(_controller);

    return Scaffold(
      appBar: AppBar(
        title: const Text("显示动画"),
      ),
      body: Center(
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.5).animate(_opacityController),
          child: AnimatedBuilder(
            animation: _expansionController,
            builder: (BuildContext context, Widget? child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade100],
                    stops: [_expansionController.value, _expansionController.value + 0.1],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _expansionController.duration = const Duration(seconds: 4);
          _expansionController.forward();

          await Future.delayed(const Duration(seconds: 4));

          _opacityController.duration = const Duration(milliseconds: 1750);
          _opacityController.repeat(reverse: true);
          await Future.delayed(const Duration(seconds: 7));
          _opacityController.reset();

          _expansionController.duration = const Duration(seconds: 8);
          _expansionController.reverse();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("显示动画"),
//       ),
//       body: Center(
//         child: Container(
//           width: 300,
//           height: 300,
//           color: Colors.blue,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
