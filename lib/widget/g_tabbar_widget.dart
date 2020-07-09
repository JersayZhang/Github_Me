import 'package:flutter/material.dart';
import 'package:github_me/widget/g_tabs.dart' as G_ME;

class GTabBarWidget extends StatefulWidget {
  final TabType type;
  final bool resizeToAvoidBottomPadding;
  final List<Widget> tabItems;
  final List<Widget> tabViews;
  final Color backgroundColor;
  final Color indicatorColor;
  final Widget title;
  final Widget drawer;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget bottomBar;
  final List<Widget> footerButtons;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onDoublePress;
  final ValueChanged<int> onSinglePress;

  GTabBarWidget({
    Key key,
    this.type = TabType.top,
    this.resizeToAvoidBottomPadding = true,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomBar,
    this.footerButtons,
    this.onPageChanged,
    this.onDoublePress,
    this.onSinglePress,
  }) : super(key: key);

  @override
  _GTabBarState createState() => _GTabBarState();
}

class _GTabBarState extends State<GTabBarWidget> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    ///初始化时创建控制器
    ///通过SingleTickerProviderStateMixin实现动画效果
    _tabController = new TabController(length: widget.tabViews.length, vsync: this);
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }

  _navigationPageChanged(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    _tabController.animateTo(index);
    widget.onPageChanged?.call(index);
  }

  _navigationTapClick(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    widget.onPageChanged?.call(index);

    ///不想要动画
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
    widget.onSinglePress?.call(index);
  }

  _navigationDoubleTapClick(index) {
    _navigationTapClick(index);
    widget.onDoublePress?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == TabType.top) {
      ///顶部tab bar
      return new Scaffold(
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton: SafeArea(child: widget.floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.footerButtons,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: new TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            onTap: _navigationTapClick,
          ),
        ),
        body: new PageView(
          controller: _pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }

    ///底部tab bar
    return new Scaffold(
      ///设置侧边画出drawer，不需要可以不设置
      drawer: widget.drawer,

      ///标题栏
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: widget.title,
      ),

      ///页面主体，PageView，用于承载tab对应的页面
      body: new PageView(
        ///必须有的控制器，与tab bar的控制器同步
        controller: _pageController,

        ///每一个tab对饮的页面主体，是一个List<Widget>
        children: widget.tabViews,
        onPageChanged: _navigationPageChanged,
      ),

      ///底部导航栏，也就是tab栏
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new SafeArea(

            ///tab bar控件
            child: new G_ME.TabBar(
          ///必须有的控制器，与pageView的控制器同步
          controller: _tabController,

          ///每一个tab item
          tabs: widget.tabItems,

          ///tab地步选中条颜色
          indicatorColor: widget.indicatorColor,
          onDoubleTap: _navigationDoubleTapClick,
          onTap: _navigationTapClick,
        )),
      ),
    );
  }
}

enum TabType { top, bottom }
