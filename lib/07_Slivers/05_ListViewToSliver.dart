import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:flutter_examples/main.dart';

/// 示例1：ListView 实现
/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Member> _members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int index) {
          final m = _members[index];
          return ListTile(
            // -- ClipOval 裁切
            leading: ClipOval(
              child: CircleAvatar(
                // child: const Text("M"),
                radius: 32,
                backgroundColor: Colors.white,
                child: Image.network(m.avatarUrl, fit: BoxFit.fitWidth),
              ),
            ),
            title: Text(m.name),
            subtitle: Text(m.sid),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
          final resp = await Dio().get(url);
          if (resp.statusCode == HttpStatus.ok) {
            final members = resp.data["rows"].map<Member>((row) {
              return Member(sid: row['sid'], name: row['sname']);
            });
            setState(() => _members = members.toList());
          }
        },
        child: const Icon(Icons.get_app),
      ),
    );
  }
}*/

/// 示例2：Sliver 实现
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Member> _members = [];

  /// 列表形式展示
  /*SliverList _buildTeamList(String teamName) {
    final teamMembers = _members.where((m) => m.team == teamName).toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final m = teamMembers[index];
        return ListTile(
          // -- ClipOval 裁切
          leading: ClipOval(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Image.network(m.avatarUrl, fit: BoxFit.fitWidth),
            ),
          ),
          title: Text(m.name),
          subtitle: Text(m.sid),
          trailing: Text(m.team),
        );
      }, childCount: teamMembers.length),
    );
  }*/

  /// Grid形式显示：
  SliverGrid _buildTeamList(String teamName) {
    final teamMembers = _members.where((m) => m.team == teamName).toList();
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final m = teamMembers[index];
        // -- GestureDetector 没有按钮点击时的水波纹效果
        // -- 所以可以使用 InkWell 实现
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailPage(member: m),
            ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Image.network(m.avatarUrl, fit: BoxFit.fitWidth),
                ),
              ),
              Text(m.name)
            ],
          ),
        );
      }, childCount: teamMembers.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sliver Examples"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() => _members.clear());
          const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
          final resp = await Dio().get(url);
          if (resp.statusCode == HttpStatus.ok) {
            final members = resp.data["rows"].map<Member>((row) {
              return Member(
                sid: row['sid'],
                name: row['sname'],
                team: row['tname'],
                pinyin: row['pinyin'],
                abbr: row['abbr'],
                tid: row['tid'],
                tname: row['tname'],
                pid: row['pid'],
                pname: row['pname'],
                nickname: row['nickname'],
                company: row['company'],
                join_day: row['join_day'],
                height: row['height'],
                birth_day: row['birth_day'],
                star_sign_12: row['star_sign_12'],
                star_sign_48: row['star_sign_48'],
                birth_place: row['birth_place'],
                speciality: row['speciality'],
                hobby: row['hobby'],
              );
            });
            setState(() => _members = members.toList());
          }
        },
        child: Scrollbar(
          child: CustomScrollView(
            slivers: [
              // -- 小技巧，如果使用下拉刷新时，会发现拖拽位置停留在第一个分组，而没有在导航栏上
              // -- 这是因为我们设置了 SliverPersistentHeader，而本身有一个AppBar
              // -- Flutter 估计认为两个都是Header，所以就以SliverPersistentHeader为标准了
              // -- 解决方案：可以插入一个占位的元素:SliverToBoxAdapter，不用给child即可。
              const SliverToBoxAdapter(),
              SliverPersistentHeader(
                delegate: _MyDelegate("Team SII", const Color(0xff91cdeb)),
                // -- 滑至顶部固定
                pinned: true,
              ),
              _buildTeamList("SII"),
              SliverPersistentHeader(
                delegate: _MyDelegate("Team NII", const Color(0xffae86bb)),
                pinned: true,
              ),
              _buildTeamList("NII"),
              SliverPersistentHeader(
                delegate: _MyDelegate("Team HII", const Color(0xfff39800)),
                pinned: true,
              ),
              _buildTeamList("HII"),
              SliverPersistentHeader(
                delegate: _MyDelegate("Team X", const Color(0xffa9cc29)),
                pinned: true,
              ),
              _buildTeamList("X"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
          final resp = await Dio().get(url);
          if (resp.statusCode == HttpStatus.ok) {
            final members = resp.data["rows"].map<Member>((row) {
              return Member(
                sid: row['sid'],
                name: row['sname'],
                team: row['tname'],
                pinyin: row['pinyin'],
                abbr: row['abbr'],
                tid: row['tid'],
                tname: row['tname'],
                pid: row['pid'],
                pname: row['pname'],
                nickname: row['nickname'],
                company: row['company'],
                join_day: row['join_day'],
                height: row['height'],
                birth_day: row['birth_day'],
                star_sign_12: row['star_sign_12'],
                star_sign_48: row['star_sign_48'],
                birth_place: row['birth_place'],
                speciality: row['speciality'],
                hobby: row['hobby'],
              );
            });
            setState(() => _members = members.toList());
          }
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _MyDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;
  _MyDelegate(this.title, this.color);

  // -- 设置显示内容
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 32,
      color: color,
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  // -- 设置最大高度
  @override
  double get maxExtent => 32;
  // - 设置最小高度
  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _MyDelegate oldDelegate) {
    // return oldDelegate.title != title;
    return true;
  }
}

class Member {
  final String sid;
  final String name;
  final String team;
  final String pinyin;
  final String abbr;
  final String tid;
  final String tname;
  final String pid;
  final String pname;
  final String nickname;
  final String company;
  final String join_day;
  final String height;
  final String birth_day;
  final String star_sign_12;
  final String star_sign_48;
  final String birth_place;
  final String speciality;
  final String hobby;

  Member({
    required this.sid,
    required this.name,
    required this.team,
    required this.pinyin,
    required this.abbr,
    required this.tid,
    required this.tname,
    required this.pid,
    required this.pname,
    required this.nickname,
    required this.company,
    required this.join_day,
    required this.height,
    required this.birth_day,
    required this.star_sign_12,
    required this.star_sign_48,
    required this.birth_place,
    required this.speciality,
    required this.hobby,
  });

  String get avatarUrl => "https://www.snh48.com/images/member/zp_$sid.jpg";

  @override
  String toString() {
    return 'Member{sid: $sid, name: $name}';
  }
}

/// 详情页
class DetailPage extends StatelessWidget {
  final Member member;
  const DetailPage({Key? key, required this.member}) : super(key: key);

  Widget _buildInfo(String label, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text(label), Text(content, textAlign: TextAlign.right)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.pink[100],
            floating: true,
            expandedHeight: 300,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                member.name,
                style: TextStyle(color: Colors.grey[800]),
              ),
              centerTitle: true,

              // -- 居中
              background: Center(
                // -- 设置padding来控制图片大小
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  // -- 出来的效是椭圆，通过控制比例AspectRatio使其成为一个正方形（正圆）
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipOval(
                      child: Image.network(
                        member.avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              collapseMode: CollapseMode.pin, /** 同时移动 */
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildInfo("拼音", member.pinyin),
                _buildInfo("加入所属", member.pname),
                _buildInfo("昵称", member.nickname),
                _buildInfo("公司", member.company),
                _buildInfo("加入日期", member.join_day),
                _buildInfo("身高", "${member.height} cm"),
                _buildInfo("生日", member.birth_day),
                _buildInfo("星座", member.star_sign_12),
                _buildInfo("出生地", member.birth_place),
                _buildInfo("特长", member.speciality),
                _buildInfo("兴趣爱好", member.hobby),
              ],
            ),
          )
        ],
      ),
    );
  }
}
