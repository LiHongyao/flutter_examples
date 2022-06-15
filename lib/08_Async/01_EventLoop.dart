import 'dart:async';

import 'package:flutter/material.dart';

/// -- 异步：Flutter 中的异步并非是多线程，Future 类似于JavaScript中的Promise
/// 1. 回调函数
/// 2. .then
/// 3. async/await

/// -- 程序无响应？
/// 1. 处理大量计算
/// 2. 等待耗时操作

/// -- 多线程（Isolate）

/// -- EventLoop: Microtask Queue（微任务） → Event Queue（事件队列/宏任务）
/// -- 流程：打开程序 → 运行main() → 微任务（有任务则处理） → 宏任务（有任务则处理） → 结束

/// 直接运行：Future.sync()/Future.value()/_.then()/...
/// 微任务：scheduleMicrotask()/Future.microtask()/_completed.then()
/// 宏任务：Future()/Future.delayed()

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getFuture() {
    return Future.error(Exception("Something got wrong."));
    // return Future(() => "Li-HONGYAO");
    // return Future.delayed(const Duration(seconds: 1), () => "周杰伦");
  }

  // async 函数自动返回 Future
  Future<int> getSomething() async {
    return 100;
  }

  Future handError() async {
    throw ('something error');
  }

  String getName() {
    debugPrint("Hello");
    return "Hello";
  }

  void testError() async {
    try {
      await handError();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    debugPrint("start");
    Future.sync(() => debugPrint("sync 1"));

    // 1. 创建微任务  B → A，一般不用微任务，主要留给Flutter内部机制用
    scheduleMicrotask(() => debugPrint("microtask 1"));
    Future.microtask(() => debugPrint("microtask 2"));
    Future.value(getName()).then((value) => debugPrint("microtask 3"));

    // 2. 创建宏任务
    Future.delayed(const Duration(seconds: 1), () => debugPrint("event 3"));
    Future(() => debugPrint("event 1"));
    Future.delayed(Duration.zero, () => debugPrint("event 2"));
    getFuture()
        .then((value) => debugPrint(value))
        .catchError((error) => debugPrint(error.toString()))
        .whenComplete(() => debugPrint("complete"));

    debugPrint("end");

    testError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Loop"),
      ),
    );
  }
}
