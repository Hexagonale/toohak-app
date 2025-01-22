import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/widgets/loading_view.dart';

import 'cubit/template_details_cubit.dart';
import 'template_details_body.dart';

class TemplateDetailsScreen extends StatelessWidget {
  const TemplateDetailsScreen({
    super.key,
    required this.id,
  });

  final String? id;

  static String getRoute({
    required String? id,
  }) {
    if (id == null) {
      return '/templates/new';
    }

    return '/templates/$id';
  }

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      // ignore: avoid_dynamic_calls
      final id = params['id']?.first as String?;
      if (id == 'new') {
        return const TemplateDetailsScreen(id: null);
      }

      return TemplateDetailsScreen(id: id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: BlocProvider<TemplateDetailsCubit>(
        create: (_) => TemplateDetailsCubit()..init(id),
        child: BlocBuilder<TemplateDetailsCubit, TemplateDetailsState>(
          builder: (_, TemplateDetailsState state) {
            switch (state) {
              case TemplateDetailsLoadingState():
                return const LoadingView();

              case TemplateDetailsLoadedState():
                return TemplateDetailsBody(state: state);

              case TemplateDetailsErrorState():
                return ErrorView(
                  error: state.error,
                );
            }
          },
        ),
      ),
    );
  }
}
