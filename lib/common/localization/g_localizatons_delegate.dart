import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_me/common/localization/default_localization.dart';

class GLocalizationDelegate extends LocalizationsDelegate<GLocalizations> {
  GLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英文
    return true;
  }

  @override
  Future<GLocalizations> load(Locale locale) {
    return new SynchronousFuture<GLocalizations>(new GLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GLocalizations> old) {
    return false;
  }

  ///全局动态代理
  static GLocalizationDelegate delegate = new GLocalizationDelegate();
}
