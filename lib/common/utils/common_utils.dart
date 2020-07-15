import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils{
  static getThemeData(Color color){
    return ThemeData(primarySwatch: color,platform: TargetPlatform.android);
  }

  static launchOutUrl(String url,BuildContext context) async {
    if(await canLaunch(url)){
      await launch(url);
    }else{
      Fluttertoast.showToast(msg: GLocalizations.i18n(context).option_web_launcher_error+": "+url);
    }
  }

  static copy(String data,BuildContext context){
    Clipboard.setData(new ClipboardData(text: data));
    Fluttertoast.showToast(msg: GLocalizations.i18n(context).option_share_copy_success);
  }

}