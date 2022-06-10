import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
        elevation: 0,
      ),
      body: const TextDemo(),
    );
  }
}

class TextDemo extends StatelessWidget {
  const TextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。",
          textDirection: TextDirection.ltr,
          // -- 显示行数
          maxLines: 3,
          // -- 处理文本溢出
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            letterSpacing: 2,
            wordSpacing: 2,

            // -- 行高
            height: 1.5,
            // -- 文本装饰线
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.double,
            decorationColor: Colors.red,
            decorationThickness: 1,
          ),
        ),
      ],
    );
  }
}
