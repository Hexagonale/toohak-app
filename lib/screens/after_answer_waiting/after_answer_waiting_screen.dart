import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'after_answer_waiting_body.dart';
import 'cubit/after_answer_waiting_cubit.dart';

class AfterAnswerWaitingScreen extends StatefulWidget {
  const AfterAnswerWaitingScreen({super.key});

  static const String route = '/after-answer-waiting';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const AfterAnswerWaitingScreen();
    },
  );

  @override
  State<AfterAnswerWaitingScreen> createState() => _AfterAnswerWaitingScreenState();
}

class _AfterAnswerWaitingScreenState extends State<AfterAnswerWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AfterAnswerWaitingCubit>(
      create: (_) => AfterAnswerWaitingCubit()..init(),
      child: BlocBuilder<AfterAnswerWaitingCubit, AfterAnswerWaitingState>(
        builder: (_, AfterAnswerWaitingState state) {
          return const AfterAnswerWaitingBody();
        },
      ),
    );
  }
}
