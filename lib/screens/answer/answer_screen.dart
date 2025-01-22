import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';

import 'answer_body.dart';
import 'cubit/answer_cubit.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({
    super.key,
    required this.event,
    required this.gameId,
  });

  final QuestionSentCloudEvent? event;
  final String gameId;

  static String getRoute(String gameId) {
    return '/answer/$gameId';
  }

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // ignore: avoid_dynamic_calls
      final gameId = params['game-id']?.first as String;

      if (context == null) {
        return AnswerScreen(
          event: null,
          gameId: gameId,
        );
      }

      final event = ModalRoute.of(context)?.settings.arguments as QuestionSentCloudEvent?;
      return AnswerScreen(
        event: event,
        gameId: gameId,
      );
    },
  );

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnswerCubit>(
      create: (_) => AnswerCubit()..init(),
      child: BlocBuilder<AnswerCubit, AnswerState>(
        builder: (_, AnswerState state) {
          if (widget.event == null) {
            return const ErrorView(
              error: 'Event is null',
            );
          }

          return AnswerBody(
            event: widget.event!,
            gameId: widget.gameId,
          );
        },
      ),
    );
  }
}
