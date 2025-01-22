import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/widgets/loading_view.dart';
import 'package:toohak/widgets/no_data_view.dart';

import 'admin_body.dart';
import 'cubit/admin_cubit.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  static const String route = '/admin';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const AdminScreen();
    },
  );

  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: BlocProvider<AdminCubit>(
          create: (_) => AdminCubit()..init(),
          child: BlocBuilder<AdminCubit, AdminState>(
            builder: (BuildContext context, AdminState state) {
              switch (state) {
                case AdminLoadedState():
                  return AdminBody(
                    state: state,
                  );

                case AdminNoDataState():
                  return const NoDataView();

                case AdminLoadingState():
                  return const LoadingView();

                case AdminErrorState():
                  return ErrorView(
                    error: state.error,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
