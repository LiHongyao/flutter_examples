import 'package:flutter/material.dart';



/// 可以通过LayoutBuilder查看当前约束
/// 可以通过BoxConstraints设置约束

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("布局约束"),
        elevation: 0,
      ),
      body: Center(
        child:  Container(
          width: 300,
          height: 300,
          color: Colors.red[200],
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 60,
              maxWidth: double.infinity,
              minHeight: 60,
              maxHeight: double.infinity,
            ).loosen(),
            // Padding 可以欺上瞒下，本来约束是300，但是有左右40的留白，所以留给logo的约束只有260
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                print("constraints1: $constraints");
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      print("constraints2: $constraints");
                      return const FlutterLogo(size: 80);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
