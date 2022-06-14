import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            title: Text("More Sliver Widget"),
            floating: true,
          ),
          // -- 透明
          // -- SliverOpacity
          // -- SliverIgnorePointer()
          // -- SliverPadding(padding: padding)
          SliverPadding(
            padding: const EdgeInsets.all(40.0),
            sliver: SliverAnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: 0.5,
              // 1对1
              sliver: SliverToBoxAdapter(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
              ),
            ),
          ),
          //  1对多
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 50,
                color: Colors.primaries[index % 18],
              );
            }, childCount: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          ),
          const SliverToBoxAdapter(
            child: Divider(thickness: 4.0, color: Colors.red),
          ),
          // -- SliverFillRemaining 填充当前视窗剩余部分
          /*const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )*/
          // -- 手动实现 SliverFillRemaining
          SliverLayoutBuilder(builder: (BuildContext context, SliverConstraints constraints) {
            print(constraints);
            return const SliverToBoxAdapter();
          }),
        ],
      ),
    );
  }
}
