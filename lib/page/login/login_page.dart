import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_me/common/address.dart';
import 'package:github_me/common/config/config.dart';
import 'package:github_me/common/local/local_storage.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/common/utils/navigator_utils.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:github_me/redux/login_redux.dart';
import 'package:github_me/widget/animated_background.dart';
import 'package:github_me/widget/g_input_widget.dart';
import 'package:github_me/widget/particle/particle_widget.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginBloC {
  @override
  Widget build(BuildContext context) {
    ///触摸收起键盘
    return new GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: new Container(
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: AnimatedBackground()),
              Positioned.fill(child: ParticlesWidget(30)),
              new Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: new Card(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: GColors.cardWhite,
                      margin: const EdgeInsets.only(left: 30.0, bottom: 30.0),
                      child: new Padding(
                        padding:
                            new EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Image(
                                image: new AssetImage(GIcons.DEFAULT_USER_ICON),
                                width: 90.0,
                                height: 90.0),
                            new Padding(padding: new EdgeInsets.all(10.0)),
                            new GInputWidget(
                              hintText: GLocalizations.i18n(context).login_username_hint_text,
                              iconData: GIcons.LOGIN_USER,
                              onChanged: (String value) {
                                _userName = value;
                              },
                              controller: userController,
                            ),
                            new Padding(padding: new EdgeInsets.all(10.0)),
                            new GInputWidget(
                              hintText: GLocalizations.i18n(context).login_password_hint_text,
                              iconData: GIcons.LOGIN_PW,
                              obscureText: true,
                              onChanged: (String value) {
                                _password = value;
                              },
                              controller: pwController,
                            ),
                            new Padding(padding: new EdgeInsets.all(10.0)),
                            Container(
                              height: 50,
                              child: Row(
                                children: <Widget>[
                                  new Expanded(

                                      ///todo
                                      ),
                                ],
                              ),
                            ),
                            new Padding(padding: new EdgeInsets.all(15.0)),
                            InkWell(
                              onTap: () {
                                ///todo
                              },
                              child: Text(
                                GLocalizations.i18n(context).switch_language,
                                style: TextStyle(color: GColors.subTextColor),
                              ),
                            ),
                            new Padding(padding: new EdgeInsets.all(15.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin LoginBloC on State<LoginPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();
  var _userName = "";
  var _password = "";

  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_usernameChange);
    pwController.removeListener(_passwordChange);
  }

  _usernameChange() {
    _userName = userController.text;
  }

  _passwordChange() {
    _password = pwController.text;
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  loginIn() async {
    Fluttertoast.showToast(
        msg: GLocalizations.i18n(context).Login_deprecated,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);

    if (_userName == null || _userName.isEmpty) {
      return;
    }
    if (_password == null || _password.isEmpty) {
      return;
    }

    ///通过redux去执行登录流程
    StoreProvider.of<GState>(context).dispatch(LoginAction(context, _userName, _password));
  }

  oauthLogin() async {
    String code = await NavigatorUtils.goLoginWebView(
        context, Address.getOAuthUrl(), "${GLocalizations.i18n(context).oauth_text}");

    if (code != null && code.length > 0) {
      StoreProvider.of<GState>(context).dispatch(OAuthAction(context, code));
    }
  }
}
