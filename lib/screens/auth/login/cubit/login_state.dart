part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  @override
  List<Object?> get props => <dynamic>[];
}

class LoginLoadedState extends LoginState {}
