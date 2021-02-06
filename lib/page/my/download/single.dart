import 'package:flutter/material.dart';

class SinglePage extends StatefulWidget {
  @override
  State createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.red,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          labelStyle: TextStyle(color: Colors.red),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(220, 0, 0, .3),
          ),
          tabs: [
            Text('单曲'),
            Text('歌手'),
            Text('专辑'),
            Text('文件夹'),
          ],
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            Center(child: Text('单曲')),
            Center(child: Text('歌手')),
            Center(child: Text('专辑')),
            Center(child: Text('文件夹')),
          ]),
        ),
      ],
    );
  }
}
