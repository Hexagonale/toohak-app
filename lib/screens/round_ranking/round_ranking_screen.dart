import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/widgets/loading_view.dart';

import 'cubit/round_ranking_cubit.dart';
import 'round_ranking_body.dart';

class RoundRankingScreen extends StatefulWidget {
  const RoundRankingScreen({
    super.key,
  });

  static const String route = '/round-ranking';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const RoundRankingScreen();
    },
  );

  @override
  State<RoundRankingScreen> createState() => _RoundRankingScreenState();
}

class _RoundRankingScreenState extends State<RoundRankingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoundRankingCubit>(
      create: (_) => RoundRankingCubit()..init(),
      child: BlocBuilder<RoundRankingCubit, RoundRankingState>(
        builder: (_, RoundRankingState state) {
          switch (state) {
            case RoundRankingLoadingState():
              return const LoadingView();

            case RoundRankingLoadedState():
              return RoundRankingBody(
                ranking: state.players,
                somebodyStillPlaying: state.somebodyStillPlaying,
              );

            case RoundRankingErrorState():
              return ErrorView(
                error: state.error,
              );
          }
        },
      ),
    );
  }
}
