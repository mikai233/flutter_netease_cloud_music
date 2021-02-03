import 'package:flutter/material.dart';

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
      ),
      drawer: Drawer(),
    );
  }
}
