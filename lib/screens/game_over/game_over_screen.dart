import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/widgets/loading_view.dart';

import 'cubit/game_over_cubit.dart';
import 'game_over_body.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({
    super.key,
    this.event,
  });

  final GameOverCloudEvent? event;

  static const String route = '/game-over';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      if (context == null) {
        return const GameOverScreen(
          event: null,
        );
      }

      GameOverCloudEvent? event = ModalRoute.of(context)?.settings.arguments as GameOverCloudEvent?;
      return GameOverScreen(
        event: event,
      );
    },
  );

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameOverCubit>(
      create: (_) => GameOverCubit()..init(),
      child: BlocBuilder<GameOverCubit, GameOverState>(
        builder: (_, GameOverState state) {
          if (widget.event == null) {
            return const ErrorView(
              error: 'Event is null',
            );
          }

          switch (state) {
            case GameOverLoadedState():
              return GameOverBody(
                event: widget.event!,
                state: state,
              );

            case GameOverInitialState():
              return const LoadingView();

            case GameOverErrorState():
              return ErrorView(
                error: state.error,
              );
          }
        },
      ),
    );
  }
}
