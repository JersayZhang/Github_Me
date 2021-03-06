import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/common/utils/navigator_utils.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:github_me/widget/diff_scale_text.dart';
import 'package:github_me/widget/mole_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;
  String text = "";
  double fontSize = 76;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    Store<GState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        text = "Welcome";
        fontSize = 60;
      });
    });
    new Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        text = "Github_Me";
        fontSize = 60;
      });
    });
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      NavigatorUtils.goLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<GState>(builder: (context, store) {
      double size = 200;
      return Material(
        child: new Container(
          color: GColors.white,
          child: Stack(
            children: <Widget>[
              new Center(
                child: new Image(image: new AssetImage('static/images/welcome.png')),
              ),
              Align(
                alignment: Alignment(0.0, 0.3),
                child: DiffScaleText(
                  text: text,
                  textStyle: GoogleFonts.akronim().copyWith(
                    color: GColors.primaryDarkValue,
                    fontSize: fontSize,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, 0.8),
                child: Mole(),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  width: size,
                  height: size,
                  child: new FlareActor(
                    "static/file/flare_flutter_logo_.flr",
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                    animation: "Placeholder",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
