import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

class QuestionParameters extends Equatable {
  const QuestionParameters({
    required this.currentQuestion,
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    required this.hint,
    required this.durationInSec,
    required this.doubleBoost,
  });

  final Question? currentQuestion;

  final String question;

  final List<String> answers;

  final int? correctAnswerIndex;

  final String? hint;

  final int? durationInSec;

  final bool? doubleBoost;

  @override
  List<Object?> get props => <Object?>[
        currentQuestion,
        question,
        answers,
        correctAnswerIndex,
        hint,
        durationInSec,
        doubleBoost,
      ];
}
