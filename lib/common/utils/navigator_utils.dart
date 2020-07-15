import 'package:flutter/cupertino.dart';
import 'package:github_me/page/home/home_page.dart';

class NavigatorUtils {
  ///跳转到主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: widget);
  }
}
