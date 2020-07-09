import 'package:flutter/material.dart';
import 'package:github_me/common/localization/g_string_base.dart';
import 'package:github_me/common/localization/g_string_en.dart';
import 'package:github_me/common/localization/g_string_zh.dart';

class GLocalizations {
  final Locale locale;

  GLocalizations(this.locale);

  ///根据不同的local。languageCode加载不同语言对应
  ///GStringEn和GStringZh都继承自GStringBase
  static Map<String, GStringBase> _localizedValues = {
    'en': new GStringEn(),
    'zh': new GStringZh(),
  };

  GStringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  ///通过Localizations加载当前的GLocalizations
  static GLocalizations of(BuildContext context) {
    return Localizations.of(context, GLocalizations);
  }

  static GStringBase i18n(BuildContext context) {
    return (Localizations.of(context, GLocalizations) as GLocalizations).currentLocalized;
  }
}
