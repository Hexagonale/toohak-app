part of 'question_cubit.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();
  @override
  List<Object?> get props => <dynamic>[];
}

class QuestionLoadedState extends QuestionState {
  const QuestionLoadedState({
    required this.question,
  });

  final Question question;

  @override
  List<Object?> get props => <Object?>[
        question,
      ];
}

class QuestionLoadingState extends QuestionState {
  const QuestionLoadingState();
}

class QuestionErrorState extends QuestionState {
  const QuestionErrorState({
    required this.error,
  });

  final String error;

  @override
  List<Object?> get props => <Object?>[
        error,
      ];
}
