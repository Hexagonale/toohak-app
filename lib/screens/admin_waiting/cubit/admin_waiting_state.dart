part of 'admin_waiting_cubit.dart';

sealed class AdminWaitingState extends Equatable {
  const AdminWaitingState();
  @override
  List<Object?> get props => <dynamic>[];
}

class AdminWaitingLoadingState extends AdminWaitingState {
  const AdminWaitingLoadingState();
}

class AdminWaitingLoadedState extends AdminWaitingState {
  const AdminWaitingLoadedState({
    required this.nicknames,
    required this.gameTemplate,
    required this.gameId,
  });
  final List<String> nicknames;
  final GameTemplate gameTemplate;
  final String gameId;

  @override
  List<dynamic> get props => <dynamic>[
        nicknames,
        gameTemplate,
        gameId,
      ];
}

class AdminWaitingErrorState extends AdminWaitingState {
  const AdminWaitingErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
