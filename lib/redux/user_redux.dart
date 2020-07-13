import 'package:github_me/redux/g_state.dart';
import 'package:redux/redux.dart';
import 'package:github_me/model/User.dart';

import 'middleware/epic_store.dart';

///redux的combineReducers，通过TypeReducer将UpdateUserAction与reducers关联起来
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

User _updateLoaded(User user, action) {
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction{}

class UserInfoMiddleware implements MiddlewareClass<GState>{

  @override
  dynamic call(Store<GState> store, dynamic action, NextDispatcher next) {
    if(action is UpdateUserAction){
      print("*********");
    }
    next(action);
  }
}

Stream<dynamic> userInfoEpic(Stream<dynamic> actions,EpicStore<GState> store){
  return null;
}
