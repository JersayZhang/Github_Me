import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_me/env/config_wrapper.dart';
import 'package:github_me/env/dev.dart';
import 'package:github_me/env/env_config.dart';
import 'package:github_me/page/home/home_page.dart';

void main() {
  runZoned(() {
    runApp(
      ConfigWrapper(
        child: null,
        config: EnvConfig.fromJson(config),
      ),
    );
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}
