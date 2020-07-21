import 'package:flutter/material.dart';

class GInputWidget extends StatefulWidget {
  final bool obscureText;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextStyle textStyle;
  final TextEditingController controller;

  GInputWidget(
      {Key key,
      this.obscureText = false,
      this.hintText,
      this.iconData,
      this.onChanged,
      this.textStyle,
      this.controller})
      : super(key: key);

  @override
  _GInputWidgetState createState() => _GInputWidgetState();
}

class _GInputWidgetState extends State<GInputWidget> {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
    );
  }
}
