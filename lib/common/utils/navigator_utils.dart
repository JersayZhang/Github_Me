import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_me/page/home/home_page.dart';
import 'package:github_me/page/login/login_page.dart';
import 'package:github_me/page/login/login_webview.dart';

class NavigatorUtils {

  ///登录页
  static goLogin(BuildContext context){
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  ///跳转到主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: widget);
  }

  static Future goLoginWebView(BuildContext context, String url, String title) {
    return NavigatorRouter(context, new LoginWebView(url, title));
  }

  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context, new CupertinoPageRoute(builder: (context) => pageContainer(widget, context)));
  }

  static Future<T> showGDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }
}
