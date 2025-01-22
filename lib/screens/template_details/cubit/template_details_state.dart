part of 'template_details_cubit.dart';

sealed class TemplateDetailsState extends Equatable {
  const TemplateDetailsState();

  @override
  List<Object?> get props => <dynamic>[];
}

class TemplateDetailsLoadingState extends TemplateDetailsState {
  const TemplateDetailsLoadingState();
}

class TemplateDetailsLoadedState extends TemplateDetailsState {
  const TemplateDetailsLoadedState({
    required this.template,
  });

  final GameTemplate? template;

  @override
  List<dynamic> get props => <dynamic>[
        template,
      ];
}

class TemplateDetailsErrorState extends TemplateDetailsState {
  const TemplateDetailsErrorState({
    required this.error,
  });

  final String error;

  @override
  List<dynamic> get props => <dynamic>[
        error,
      ];
}
