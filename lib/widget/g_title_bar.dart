import 'package:flutter/material.dart';

class GTitleBar extends StatelessWidget {
  final String title;
  final IconData iconData;
  final ValueChanged onRightIconPressed;
  final bool needRightLocalIcon;
  final Widget rightWidget;
  final GlobalKey rightKey = GlobalKey();

  GTitleBar(this.title,
      {this.iconData, this.onRightIconPressed, this.needRightLocalIcon = false, this.rightWidget});

  @override
  Widget build(BuildContext context) {
    Widget widget = rightWidget;
    if (rightWidget == null) {
      widget = (needRightLocalIcon)
          ? new IconButton(
              icon: new Icon(
                iconData,
                key: rightKey,
                size: 19.0,
              ),
              onPressed: () {
                RenderBox renderBox = rightKey.currentContext?.findRenderObject();
                var position = renderBox.localToGlobal(Offset.zero);
                var size = renderBox.size;
                var centerPosition = Offset(
                  position.dx + size.width / 2,
                  position.dy + size.height / 2,
                );
                onRightIconPressed?.call(centerPosition);
              })
          : new Container();
    }
    return Container(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget,
        ],
      ),
    );
  }
}
