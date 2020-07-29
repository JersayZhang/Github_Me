import 'package:flutter/cupertino.dart';
import 'package:github_me/common/dao/user_dao.dart';
import 'package:github_me/common/utils/navigator_utils.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:redux/redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

final LoginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginSuccessAction>(_loginResult),
  TypedReducer<bool, LogoutAction>(_logoutResult),
]);

bool _loginResult(bool result, LoginSuccessAction action) {
  if (action.success == true) {
    NavigatorUtils.goHome(action.context);
  }
  return action.success;
}

bool _logoutResult(bool result, LogoutAction action) {
  return true;
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

class LoginAction {
  final BuildContext context;
  final String username;
  final String password;

  LoginAction(this.context, this.username, this.password);
}

class OAuthAction {
  final BuildContext context;
  final String code;

  OAuthAction(this.context, this.code);
}

class LoginMiddleware implements MiddlewareClass<GState> {
  @override
  dynamic call(Store<GState> store, dynamic action, NextDispatcher next) {
    if (action is LogoutAction) {
      UserDao.clearAll(store);
      ;
      CookieManager().clearCookies();

      ///todo
      NavigatorUtils.goLogin(action.context);
    }
    next(action);
  }
}
