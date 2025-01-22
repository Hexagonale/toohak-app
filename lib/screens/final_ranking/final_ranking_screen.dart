import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/round_ranking/round_ranking_body.dart';
import 'package:toohak/widgets/loading_view.dart';

import 'cubit/final_ranking_cubit.dart';

class FinalRankingScreen extends StatefulWidget {
  const FinalRankingScreen({
    super.key,
  });

  static const String route = '/final-ranking';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const FinalRankingScreen();
    },
  );

  @override
  State<FinalRankingScreen> createState() => _FinalRankingScreenState();
}

class _FinalRankingScreenState extends State<FinalRankingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FinalRankingCubit>(
      create: (_) => FinalRankingCubit()..init(),
      child: BlocBuilder<FinalRankingCubit, FinalRankingState>(
        builder: (_, FinalRankingState state) {
          switch (state) {
            case FinalRankingLoadedState():
              return RoundRankingBody(
                ranking: state.players,
                isFinal: true,
                somebodyStillPlaying: state.somebodyStillPlaying,
              );

            case FinalRankingLoadingState():
              return const LoadingView();

            case FinalRankingErrorState():
              return ErrorView(
                error: state.error,
              );
          }
        },
      ),
    );
  }
}
