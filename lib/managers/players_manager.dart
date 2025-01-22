import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:toohak/_toohak.dart';

class PlayersManager {
  PlayersManager({
    required CloudEventsManager cloudEventsManager,
  }) : _cloudEventsManager = cloudEventsManager;

  final BehaviorSubject<List<String>> _players$ = BehaviorSubject<List<String>>.seeded(<String>[]);
  StreamSubscription<dynamic>? subscription;
  final CloudEventsManager _cloudEventsManager;

  ValueStream<List<String>> get players {
    return _players$;
  }

  Future<bool> init() async {
    subscription = _cloudEventsManager.cloudEvents.listen(_onEvent);
    return true;
  }

  Future<void> _onEvent(CloudEvent event) async {
    if (event is! PlayerJoinedCloudEvent) {
      return;
    }

    final players = _players$.value.toList();
    players.add(event.username);

    _players$.add(players);
  }

  void clean(){
    _players$.add(<String>[]);
  }
}
