import 'package:flutter/material.dart';
import 'package:github_me/common/config/config.dart';
import 'package:github_me/env/env_config.dart';

class ConfigWrapper extends StatelessWidget {
  final EnvConfig config;
  final Widget child;

  ConfigWrapper({Key key, this.config, this.child});

  @override
  Widget build(BuildContext context) {
    ///设置Config.Debug的静态变量
    Config.DEBUG = this.config.debug;
    print("ConfigWrapper build ${Config.DEBUG}");
    return new _InheritedConfig(config: this.config, child: this.child);
  }

  static EnvConfig of(BuildContext context) {
    final _InheritedConfig inheritedConfig = context.inheritFromWidgetOfExactType(_InheritedConfig);
    return inheritedConfig.config;
  }
}

class _InheritedConfig extends InheritedWidget {
  final EnvConfig config;

  const _InheritedConfig({Key key, @required this.config, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) => config != oldWidget.config;
}
