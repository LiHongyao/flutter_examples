import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GitEvents> _events = [];

  // -- methods
  Future _refresh() async {
    // -- 请求数据
    final resp = await Dio().get("https://api.github.com/events");
    /*
      print(resp.statusCode);
      print(resp.runtimeType);
      print(resp.data);*/
    if (resp.statusCode == HttpStatus.ok) {
      List data = resp.data;
      setState(() {
        _events.clear();
        _events.addAll(data.map((e) => GitEvents(e)));
      });
      // print(_events);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("示例"),
        elevation: 0,
      ),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await _refresh();
          },
          child: ListView(
            children: _events.map<Widget>((GitEvents event) {
              return Dismissible(
                key: ValueKey(event.id),
                confirmDismiss: (DismissDirection _) async {
                  return showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Do you want to delete this item?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (DismissDirection _) {
                  setState(() {
                    _events.removeWhere((e) => e.id == event.id);
                  });
                },
                child: ListTile(
                  leading: Image.network(event.avatarUrl),
                  title: Text(event.userName),
                  subtitle: Text(event.repoName),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class GitEvents {
  late String id;
  late String userName;
  late String avatarUrl;
  late String repoName;
  // -- 构造函数
  GitEvents(json) {
    id = json['id'];
    userName = json["actor"]["login"];
    avatarUrl = json["actor"]["avatar_url"];
    repoName = json["repo"]["name"];
  }

  @override
  String toString() {
    return 'GitEvents{id: $id, userName: $userName, avatarUrl: $avatarUrl, repoName: $repoName}';
  }
}
