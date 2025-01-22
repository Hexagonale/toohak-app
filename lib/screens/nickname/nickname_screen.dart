import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/screens/nickname/cubit/nickname_cubit.dart';

import 'nickname_body.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({
    super.key,
    required this.code,
  });

  final String code;

  static String getRoute({
    required String code,
  }) {
    return '/nickname/$code';
  }

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // ignore: avoid_dynamic_calls
      final code = (params['code']?.first as String?) ?? '';

      return NicknameScreen(
        code: code,
      );
    },
  );

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NicknameCubit>(
      create: (_) => NicknameCubit()..init(),
      child: BlocBuilder<NicknameCubit, NicknameState>(
        builder: (_, NicknameState state) {
          switch (state) {
            case NicknameLoadedState():
              return NicknameBody(
                code: widget.code,
              );
          }
        },
      ),
    );
  }
}
