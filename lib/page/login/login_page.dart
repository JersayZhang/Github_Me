import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_me/common/config/config.dart';
import 'package:github_me/common/local/local_storage.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/utils/navigator_utils.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:github_me/redux/login_redux.dart';

class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
    ///todo 去web页面登录
  }
}
