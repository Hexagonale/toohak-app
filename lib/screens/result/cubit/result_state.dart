part of 'result_cubit.dart';

sealed class ResultState extends Equatable {
  const ResultState();
  @override
  List<Object?> get props => <dynamic>[];
}

class ResultLoadedState extends ResultState {
  const ResultLoadedState();

  @override
  List<Object?> get props => <Object?>[];
}

class ResultErrorState extends ResultState {
  const ResultErrorState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => <Object?>[
        error,
      ];
}
