import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// 【示例1】：Flutter -- Hero 动画
/*class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // -- 动画效果放慢5倍
    timeDilation = 5.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const imgUrl = 'https://qn.d-dou.com/dcep/dbean/3b100d2dde0e4037a33f26df8a4b5fb171dw0p.jpg';
    return Scaffold(
      appBar: AppBar(
        title: const Text("其他动画"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Details(path: imgUrl)));
          },
          child: Hero(
            tag: imgUrl,
            child: Image.network(
              imgUrl,
              width: 160,
            ),
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String path;
  const Details({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Hero(
                tag: path,
                child: Image.network(
                  path,
                  width: 160,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "周杰伦",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '周杰伦出生于台湾省新北市，祖籍福建省泉州市永春县 [19]  。4岁的时候，母亲叶惠美把他送到淡江山叶幼儿音乐班学习钢琴 [20]  。初中二年级时，父母因性格不合离婚，周杰伦归母亲叶惠美抚养。中考时，没有考上普通高中，同年，因为擅长钢琴而被淡江中学第一届音乐班录取。高中毕业以后，两次报考台北大学音乐系均没有被录取，于是开始在一家餐馆打工',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/

/// 【示例2】：直接操作底层的 CustomPainter
class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Snowflake> _snowflakes = List.generate(100, (index) => Snowflake());

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    super.initState();
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
        title: const Text("Custom Painter"),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.lightBlue, Colors.white],
                stops: [0.0, 0.7, 0.95]),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              for (var snowflake in _snowflakes) {
                snowflake.fall();
              }
              return CustomPaint(
                painter: MyPainter(_snowflakes),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Snowflake> _snowflakes;

  MyPainter(this._snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    final whitePaint = Paint()..color = Colors.white;

    // -- 圆
    canvas.drawCircle(size.center(const Offset(0, 80)), 60.0, whitePaint);
    // -- 椭圆
    canvas.drawOval(
      Rect.fromCenter(center: size.center(const Offset(0, 250)), width: 200, height: 250),
      whitePaint,
    );
    for (var snowflake in _snowflakes) {
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;
  fall() {
    y += velocity;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}

/// 【示例3】 - 插件动画
/// https://rive.app/

