import 'package:flutter/material.dart';

/// 再一次回顾，走进Sliver的大门：CustomScrollView

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            // centerTitle: true,
            // title: Text("Sliver App Bar"),
            // -- 稍微一往回滚，显示导航栏
            floating: true,
            // -- 稍微一往回滚，松手时自动全部显示/隐藏（和floating结合使用）
            snap: true,
            // -- 设置拉伸效果
            expandedHeight: 200,
            // -- 是否允许拉伸，注意，安卓机型需设置 CustomScrollView.physics 为 BouncingScrollPhysics
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text("FlexibleSpaceBar Title"),
              // -- 拉伸效果，需设置 stretch = true
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
                StretchMode.fadeTitle
              ],
            ),
            // 一直显示导航栏
            // pinned: true,
          ),
          const SliverToBoxAdapter(
            // -- Placeholder 占位组件，打个X，表示功能暂未实现
            child: Placeholder(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),
                const FlutterLogo(),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(size: 200),
                const FlutterLogo(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
