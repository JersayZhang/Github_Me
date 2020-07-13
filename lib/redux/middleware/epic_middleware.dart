import 'dart:async';

import 'package:redux/redux.dart';

class EpicMiddleware<State> extends MiddlewareClass<State>{

  EpicMiddleware();

  @override
  dynamic call(Store<State> store, dynamic action, NextDispatcher next) {

  }
}