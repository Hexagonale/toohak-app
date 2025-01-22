import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';
import 'login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String route = '/login';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const LoginScreen();
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (_, LoginState state) {
          switch (state) {
            case LoginLoadedState():
              return const LoginBody();
          }
        },
      ),
    );
  }
}
