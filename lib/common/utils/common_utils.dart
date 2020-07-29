import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_me/common/config/config.dart';
import 'package:github_me/common/local/local_storage.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/common/utils/navigator_utils.dart';
import 'package:github_me/redux/g_state.dart';
import 'package:github_me/redux/locale_redux.dart';
import 'package:github_me/widget/g_flex_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redux/redux.dart';

class CommonUtils {

  static Locale curLocale;

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }

  static launchOutUrl(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
          msg: GLocalizations
              .i18n(context)
              .option_web_launcher_error + ": " + url);
    }
  }

  static copy(String data, BuildContext context) {
    Clipboard.setData(new ClipboardData(text: data));
    Fluttertoast.showToast(msg: GLocalizations
        .i18n(context)
        .option_share_copy_success);
  }

  static showLanguageDialog(BuildContext context) {
    List<String> list = [
      GLocalizations
          .i18n(context)
          .home_language_default,
      GLocalizations
          .i18n(context)
          .home_language_zh,
      GLocalizations
          .i18n(context)
          .home_language_en,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeLocale(StoreProvider.of<GState>(context), index);
      LocalStorage.save(Config.LOCALE, index.toString());
    },height: 150.0);
  }

  ///列表item dialog
  static Future<Null> showCommitOptionDialog(BuildContext context,
      List<String> commitMaps,
      ValueChanged<int> onTap, {
        width = 250.0,
        height = 400.0,
        List<Color> colorList,
      }) {
    return NavigatorUtils.showGDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: GColors.white,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return GFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null ? colorList[index] : Theme
                          .of(context)
                          .primaryColor,
                      text: commitMaps[index],
                      textColor: GColors.white,
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }

  /**
   * 切换语言
   */
  static changeLocale(Store<GState> store, int index) {
    Locale locale = store.state.platformLocale;
    if (Config.DEBUG) {
      print(store.state.platformLocale);
    }
    switch (index) {
      case 1:
        locale = Locale('ZH', "CH");
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    curLocale = locale;
    store.dispatch(RefreshLocaleAction(locale));
  }
}
