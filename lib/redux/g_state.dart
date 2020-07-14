import 'package:flutter/material.dart';
import 'package:github_me/model/User.dart';
import 'package:github_me/redux/locale_redux.dart';
import 'package:github_me/redux/login_redux.dart';
import 'package:github_me/redux/middleware/epic_middleware.dart';
import 'package:github_me/redux/theme_redux.dart';
import 'package:github_me/redux/user_redux.dart';
import 'package:redux/redux.dart';

class GState {
  ///用户信息
  User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///是否登录
  bool login;

  ///构造方法
  GState({this.userInfo, this.themeData, this.locale, this.login});
}

///创建Reducer
GState appReducer(GState state, action) {
  return GState(

    ///通过UserReducer将GState内的userInfo和action关联起来
      userInfo: UserReducer(state.userInfo, action),
      themeData: ThemeDataReducer(state.themeData, action),
      locale: LocaleReducer(state.locale, action),
      login: LoginReducer(state.login, action),
  );
}

final List<Middleware<GState>> middleware=[
  EpicMiddleware<GState>(userInfoEpic),
];



