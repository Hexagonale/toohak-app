part of 'admin_cubit.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => <dynamic>[];
}

class AdminNoDataState extends AdminState {
  const AdminNoDataState();
}

class AdminLoadingState extends AdminState {
  const AdminLoadingState();
}

class AdminLoadedState extends AdminState {
  const AdminLoadedState({
    required this.templates,
  });

  final List<GameTemplate> templates;

  @override
  List<dynamic> get props => <dynamic>[
        templates,
      ];
}

class AdminErrorState extends AdminState {
  const AdminErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
