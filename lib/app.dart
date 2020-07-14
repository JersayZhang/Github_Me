import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_me/common/event/http_error_event.dart';
import 'package:github_me/common/event/index.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/localization/g_localizatons_delegate.dart';
import 'package:github_me/common/net/code.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/common/utils/common_utils.dart';
import 'package:github_me/page/welcome_page.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:redux/redux.dart';
import 'package:github_me/model/User.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener, NavigatorObserver {
  final store = new Store<GState>(
    appReducer,

    ///拦截器
    middleware: middleware,

    ///初始化数据
    initialState: new GState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(GColors.primarySwatch),
        locale: Locale('zh', 'CH')),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      navigator.context;
      navigator;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<GState>(builder: (context, store) {
        store.state.platformLocale = WidgetsBinding.instance.window.locale;
        return new MaterialApp(
          ///多语言代理实现
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GLocalizationDelegate.delegate,
          ],
          supportedLocales: [store.state.locale],
          locale: store.state.locale,
          theme: store.state.themeData,
          navigatorObservers: [this],

          routes: {
            WelcomePage.sName: (context) {
              _context = context;
              return WelcomePage();
            }
          },
        );
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(GLocalizations.i18n(_context).network_error);
        break;
      case 401:
        showToast(GLocalizations.i18n(_context).network_error_401);
        break;
      case 403:
        showToast(GLocalizations.i18n(_context).network_error_403);
        break;
      case 404:
        showToast(GLocalizations.i18n(_context).network_error_404);
        break;
      case 422:
        showToast(GLocalizations.i18n(_context).network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast(GLocalizations.i18n(_context).network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast(GLocalizations.i18n(_context).github_refused);
        break;
      default:
        showToast(GLocalizations.i18n(_context).network_error_unknown + " " + message);
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
  }
}
