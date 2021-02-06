import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netease_cloud_music/config/app_color.dart';
import 'package:flutter_netease_cloud_music/page/my/download/mv.dart';
import 'package:flutter_netease_cloud_music/page/my/download/single.dart';
import 'package:flutter_netease_cloud_music/page/my/download/sound.dart';

class DownloadPage extends StatefulWidget {
  @override
  State createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage>
    with TickerProviderStateMixin {
  TabController _appbarTabController;

  @override
  void initState() {
    super.initState();
    _appbarTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _appbarTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.foregroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        backgroundColor: Color.fromRGBO(AppColor.foregroundColor.red,
            AppColor.foregroundColor.green, AppColor.foregroundColor.blue, 1),
        centerTitle: true,
        title: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              // width: constraints.maxWidth / 3 * 2,
              child: TabBar(
                labelColor: Colors.black,
                controller: _appbarTabController,
                labelStyle: TextStyle(fontSize: 18),
                labelPadding: const EdgeInsets.symmetric(vertical: 2),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                tabs: [Text('单曲'), Text('声音'), Text('MV')],
              ),
            );
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: TabBarView(
        controller: _appbarTabController,
        children: [
          SinglePage(),
          SoundPage(),
          MVPage(),
        ],
      ),
    );
  }
}
