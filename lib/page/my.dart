import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netease_cloud_music/config/app_color.dart';

class MyPage extends StatefulWidget {
  @override
  State createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _listenerAdded = false;
  AnimationController _appbarAnimationController;
  Animation<double> _appbarAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _appbarAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    CurvedAnimation(
        parent: _appbarAnimationController, curve: Curves.easeInOut);
    _appbarAnimation =
        Tween(begin: -10.0, end: 0.0).animate(_appbarAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
    _appbarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: _buildAppBar(context),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Container(
                    child: FlutterLogo(),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  Column(
                    children: [
                      Text('时光回忆2017'),
                      Row(
                        children: [Text('balabal'), Text('lv')],
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.foregroundColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Icon(Icons.music_note_rounded),
                              Text('本地/下载')
                            ],
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Text('other'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.foregroundColor,
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: FlutterLogo(
                      size: 60,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('我喜欢的音乐'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '10008首',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.headset_rounded),
                        Text('心动模式'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: MySliverDelegate(builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: AppColor.backgroundColor,
                child: TabBar(
                  labelColor: Colors.black,
                  tabs: [Text('创建歌单'), Text('收藏歌单'), Text('歌单助手')],
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  controller: _tabController,
                ),
              );
            }),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('${index + 1}'),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    double opacity = 0;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        if (!_listenerAdded) {
          _listenerAdded = true;
          _scrollController.addListener(() {
            opacity = _scrollController.offset / 56;
            if (opacity > 1) {
              opacity = 1;
            }
            final direction = _scrollController.position.userScrollDirection;
            if (direction == ScrollDirection.forward && opacity < 0.5) {
              _appbarAnimationController.reverse();
            } else if (direction == ScrollDirection.reverse && opacity > 0.5) {
              _appbarAnimationController.forward();
            }
            setState(() {});
          });
        }
        return AppBar(
          foregroundColor: Colors.black,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Color.fromRGBO(
              AppColor.foregroundColor.red,
              AppColor.foregroundColor.green,
              AppColor.foregroundColor.blue,
              opacity),
          centerTitle: true,
          elevation: 0,
          title: AnimatedBuilder(
            animation: _appbarAnimationController,
            builder: (BuildContext context, Widget child) {
              return Transform.translate(
                offset: Offset(0, _appbarAnimation.value),
                child: Opacity(
                  child: child,
                  opacity: _appbarAnimationController.value,
                ),
              );
            },
            child: _buildAppbarTitle(),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              final scaffoldState =
                  context.findRootAncestorStateOfType<ScaffoldState>();
              if (scaffoldState != null && scaffoldState.hasDrawer) {
                scaffoldState.openDrawer();
              }
            },
          ),
        );
      },
    );
  }

  _buildAppbarTitle() {
    return GestureDetector(
      child: Wrap(
        children: [
          Container(
            height: 30,
            child: CircleAvatar(
              child: FlutterLogo(),
            ),
          ),
          Text('时光回忆')
        ],
        crossAxisAlignment: WrapCrossAlignment.center,
      ),
      onTap: () {
        print('on title tap');
      },
    );
  }
}

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  final WidgetBuilder builder;

  MySliverDelegate({@required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent {
    return 60.0;
  }

  @override
  double get minExtent {
    return 60.0;
  }
}
