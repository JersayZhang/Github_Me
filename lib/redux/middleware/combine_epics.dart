import 'package:rxdart/rxdart.dart';

import 'epic.dart';

import 'epic_store.dart';

Epic<State> combineEpics<State>(List<Epic<State>> epics) {
  return (Stream<dynamic> actions, EpicStore<State> store) {
    return MergeStream<dynamic>(epics.map((epic) => epic(actions, store)).toList());
  };
}
