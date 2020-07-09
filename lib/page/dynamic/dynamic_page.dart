import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  @override
  DynamicPageState createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin<DynamicPage>, WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool get wantKeepAlive =>true;
}
