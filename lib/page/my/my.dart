import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_netease_cloud_music/config/app_color.dart';
import 'package:flutter_netease_cloud_music/config/cloud_over_scroll_behavior.dart';
import 'package:flutter_netease_cloud_music/page/my/download/dowload.dart';
import 'package:flutter_netease_cloud_music/utils/utils.dart';

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
  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _persistentHeaderKey = GlobalKey();
  final GlobalKey _createSongListKey = GlobalKey();
  final GlobalKey _collectSongListKey = GlobalKey();
  final GlobalKey _songListHelper = GlobalKey();
  bool _isScrollAnimating = false;

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
    _scrollController.addListener(() {
      if (!_isScrollAnimating) {
        final offset = _scrollController.offset;
        if (offset >=
            _getGlobalOffsetY(_collectSongListKey.currentContext) -
                _getGlobalOffsetY(_headerKey.currentContext) -
                _persistentHeaderKey.currentContext.size.height) {
          if (_tabController.index != 1) {
            _tabController.animateTo(1);
          }
        } else if (offset >=
            _getGlobalOffsetY(_songListHelper.currentContext) -
                _getGlobalOffsetY(_headerKey.currentContext) -
                _persistentHeaderKey.currentContext.size.height) {
          if (_tabController.index != 2) {
            _tabController.animateTo(2);
          }
        } else {
          if (_tabController.index != 0) {
            _tabController.animateTo(0);
          }
        }
      }
    });
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
      body: ScrollConfiguration(
        behavior: CloudOverscrollBehavior(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                key: _headerKey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              pushPage(context, DownloadPage());
                            },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                child: InkWell(
                  onTap: () {
                    print('tapa');
                  },
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
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
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: MySliverDelegate(builder: (BuildContext context) {
                return Container(
                  key: _persistentHeaderKey,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: AppColor.backgroundColor,
                  child: TabBar(
                    labelColor: Colors.black,
                    labelPadding: const EdgeInsets.symmetric(vertical: 4),
                    labelStyle: TextStyle(fontSize: 16),
                    tabs: [Text('创建歌单'), Text('收藏歌单'), Text('歌单助手')],
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3,
                    controller: _tabController,
                    onTap: (index) {
                      _isScrollAnimating = true;
                      switch (index) {
                        case 0:
                          _scrollController
                              .animateTo(
                                  _getGlobalOffsetY(
                                          _createSongListKey.currentContext) -
                                      _getGlobalOffsetY(
                                          _headerKey.currentContext) -
                                      _persistentHeaderKey
                                          .currentContext.size.height,
                                  duration: Duration(milliseconds: 375),
                                  curve: Curves.easeInOut)
                              .then((value) => _isScrollAnimating = false);
                          _tabController.animateTo(0);
                          break;
                        case 1:
                          _scrollController
                              .animateTo(
                                  _getGlobalOffsetY(
                                          _collectSongListKey.currentContext) -
                                      _getGlobalOffsetY(
                                          _headerKey.currentContext) -
                                      _persistentHeaderKey
                                          .currentContext.size.height,
                                  duration: Duration(milliseconds: 375),
                                  curve: Curves.easeInOut)
                              .then((value) => _isScrollAnimating = false);
                          _tabController.animateTo(1);
                          break;
                        case 2:
                          _scrollController
                              .animateTo(
                                  _getGlobalOffsetY(
                                          _songListHelper.currentContext) -
                                      _getGlobalOffsetY(
                                          _headerKey.currentContext) -
                                      _persistentHeaderKey
                                          .currentContext.size.height,
                                  duration: Duration(milliseconds: 375),
                                  curve: Curves.easeInOut)
                              .then((value) => _isScrollAnimating = false);
                          _tabController.animateTo(2);
                          break;
                      }
                    },
                  ),
                );
              }),
            ),
            _buildSongList(_createSongListKey),
            _buildSongList(_collectSongListKey),
            SliverToBoxAdapter(
              child: Container(
                key: _songListHelper,
                height: 200,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.foregroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Text(
                            '歌单助手',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSongList(GlobalKey globalKey) {
    return SliverToBoxAdapter(
      child: Container(
        key: globalKey,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.foregroundColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '创建歌单',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    minimumSize: Size(5, 5),
                  ),
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    minimumSize: Size(5, 5),
                  ),
                  child: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: AppColor.foregroundColor,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey,
                          ),
                          child: FlutterLogo(),
                        ),
                        Column(
                          children: [
                            Text('dfsrerfsdfsdf'),
                            Text('10首'),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            minimumSize: Size(5, 5),
                          ),
                          child: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
            )
          ],
        ),
      ),
    );
  }

  double _getGlobalOffsetY(BuildContext buildContext) {
    final RenderBox renderBox = buildContext.findRenderObject();
    return renderBox.localToGlobal(Offset.zero).dy;
  }

  double _getLocalOffsetY(BuildContext buildContext) {
    final RenderBox renderBox = buildContext.findRenderObject();
    return renderBox.globalToLocal(Offset.zero).dy;
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
              if (_appbarAnimationController.status !=
                  AnimationStatus.reverse) {
                _appbarAnimationController.reverse();
              }
            } else if (direction == ScrollDirection.reverse && opacity > 0.5) {
              if (_appbarAnimationController.status !=
                  AnimationStatus.forward) {
                _appbarAnimationController.forward();
              }
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
