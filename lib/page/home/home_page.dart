import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/page/dynamic/dynamic_page.dart';
import 'package:github_me/page/trend/trend_page.dart';
import 'package:github_me/page/user/my_page.dart';
import 'package:github_me/widget/g_tabbar_widget.dart';
import 'package:github_me/widget/g_title_bar.dart';

/// 主页
class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<DynamicPageState> dynamicKey = new GlobalKey();
  final GlobalKey<TrendPageState> trendKey = new GlobalKey();
  final GlobalKey<MyPageState> myKey = new GlobalKey();

  ///不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是Android，返回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.HOME',
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(icon, size: 16.0),
          new Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(GIcons.MAIN_DT, GLocalizations.i18n(context).home_dynamic),
      _renderTab(GIcons.MAIN_QS, "趋势"),
      _renderTab(GIcons.MAIN_MY, "我的"),
    ];

    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new GTabBarWidget(
        drawer: null,
        type: TabType.bottom,
        tabItems: tabs,
        tabViews: [
          new DynamicPage(key: dynamicKey),
          new TrendPage(key: trendKey),
          new MyPage(key: myKey),
        ],
        onDoublePress: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
          }
        },
        backgroundColor: GColors.primarySwatch,
        indicatorColor: GColors.white,
        title: GTitleBar(
          "111",
          iconData: GIcons.MAIN_SEARCH,
          needRightLocalIcon: true,
          onRightIconPressed: (centerPosition) {
            ///搜索
          },
        ),
      ),
    );
  }
}
