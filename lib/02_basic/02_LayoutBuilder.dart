import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 可以通过 LayoutBuilder 查看当前约束
/// 可以通过 BoxConstraints 设置约束

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("布局约束"),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, Constraints constraints) {
          debugPrint("Scaffold constraints: $constraints");
          return Center(
            child: LayoutBuilder(
              builder: (BuildContext context, Constraints constraints) {
                debugPrint("Center constraints: $constraints");
                return Container(
                  width: 300,
                  height: 300,
                  color: Colors.red[200],
                  child: ConstrainedBox(
                    // 如果父级明确指定了尺寸，则ConstrainedBox设置的约束无效
                    constraints: const BoxConstraints(
                      minWidth: 60,
                      maxWidth: double.infinity,
                      minHeight: 60,
                      maxHeight: double.infinity,
                    ).loosen(),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        debugPrint("ConstrainedBox: $constraints");
                        // Padding 可以欺上瞒下，本来约束是300，但是有左右40的留白，所以留给logo的约束只有260
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              debugPrint("Padding constraints: $constraints");
                              return const FlutterLogo(size: 80);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          );
        },
      ),
    );
  }
}
