import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud_music/api/cloud_api.dart';

class MyPage extends StatefulWidget {
  @override
  State createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter网易云音乐"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            final scaffoldState =
                context.findAncestorStateOfType<ScaffoldState>();
            if (scaffoldState.hasDrawer) {
              scaffoldState.openDrawer();
            }
          },
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            var r = await CloudApi().search(keywords: '暖暖');
            r.data['result']['songs'].forEach(print);
          },
          child: Text('test'),
        ),
      ),
    );
  }
}
