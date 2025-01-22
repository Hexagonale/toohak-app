import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/widgets/loading_view.dart';
import 'admin_waiting_body.dart';
import 'cubit/admin_waiting_cubit.dart';

class AdminWaitingScreen extends StatefulWidget {
  const AdminWaitingScreen({
    super.key,
    required this.code,
  });

  final String code;

  static String getRoute({
    required String code,
  }) {
    return '/admin-waiting/$code';
  }

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // ignore: avoid_dynamic_calls
      final code = params['code']?.first as String;

      return AdminWaitingScreen(
        code: code,
      );
    },
  );

  @override
  State<AdminWaitingScreen> createState() => _AdminWaitingScreenState();
}

class _AdminWaitingScreenState extends State<AdminWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminWaitingCubit>(
      create: (_) => AdminWaitingCubit()..init(),
      child: BlocBuilder<AdminWaitingCubit, AdminWaitingState>(
        builder: (_, AdminWaitingState state) {
          switch (state) {
            case AdminWaitingLoadedState():
              return AdminWaitingBody(
                state: state,
                code: widget.code,
              );

            case AdminWaitingLoadingState():
              return const LoadingView();

            case AdminWaitingErrorState():
              return ErrorView(
                error: state.error,
              );
          }
        },
      ),
    );
  }
}
