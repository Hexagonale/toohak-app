import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';
import 'package:uuid/uuid.dart';

part 'template_details_state.dart';

class TemplateDetailsCubit extends ThCubit<TemplateDetailsState> {
  TemplateDetailsCubit() : super(const TemplateDetailsLoadingState());

  final GameTemplateDataManager _gameTemplateDataManager = sl();
  final ProfilesDataManager _profilesDataManager = sl();

  StreamSubscription<dynamic>? _subscription;

  Future<void> init(String? id) async {
    final userId = appSession.currentUser?.uid;
    if (userId == null) {
      emit(
        const TemplateDetailsErrorState(
          error: 'Cannot find user',
        ),
      );

      return;
    }

    if (id == null) {
      emit(
        const TemplateDetailsLoadedState(
          template: null,
        ),
      );

      return;
    }

    await _gameTemplateDataManager.fetchWithId(id);

    await _profilesDataManager.fetchWithId(userId);

    _subscription = _gameTemplateDataManager.dataForId$(id).listen(
      (GameTemplate? template) {
        if (template == null) {
          emit(
            const TemplateDetailsErrorState(
              error: 'Cannot find template',
            ),
          );

          return;
        }
        emit(
          TemplateDetailsLoadedState(
            template: template,
          ),
        );
      },
    );
  }

  Future<bool> save({
    required GameTemplate? template,
    required String name,
    required List<QuestionParameters> params,
    required GameType? type,
    required bool ready,
  }) async {
    final userId = appSession.currentUser?.uid;
    if (userId == null) {
      return false;
    }

    bool result = false;

    final questions = <Question>[];
    for (QuestionParameters param in params) {
      final question = await saveQuestion(param: param);
      if (question != null) {
        questions.add(question);
      }
    }

    if (template == null) {
      final gameTemplateId = await _gameTemplateDataManager.addGameTemplate(
        gameTemplateWriteRequest: GameTemplateWriteRequest(
          userId: userId,
          questions: questions,
          name: name,
          type: type,
          ready: ready,
        ),
      );

      if (gameTemplateId == null) {
        BotToast.closeAllLoading();

        return false;
      }

      result = await _profilesDataManager.addGameTemplate(
        id: userId,
        gameTemplateId: gameTemplateId,
      );
    } else {
      result = await _gameTemplateDataManager.updateGameTemplate(
        gameTemplateWriteRequest: GameTemplateWriteRequest(
          userId: userId,
          questions: questions,
          name: name,
          type: type,
          ready: ready,
        ),
        id: template.id,
      );
    }

    BotToast.closeAllLoading();

    return result;
  }

  Future<Question?> saveQuestion({
    required QuestionParameters param,
  }) async {
    BotToast.showLoading();

    if (param.currentQuestion == null) {
      final id = const Uuid().v4();

      return Question(
        id: id,
        question: param.question,
        answers: param.answers,
        correctAnswerIndex: param.correctAnswerIndex,
        hint: param.hint,
        durationInSec: param.durationInSec,
        doubleBoost: param.doubleBoost,
      );
    } else {
      return Question(
        question: param.question,
        answers: param.answers,
        correctAnswerIndex: param.correctAnswerIndex,
        hint: param.hint,
        durationInSec: param.durationInSec,
        doubleBoost: param.doubleBoost,
        id: param.currentQuestion!.id,
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
