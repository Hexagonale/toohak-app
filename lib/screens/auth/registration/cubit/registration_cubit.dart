import 'package:equatable/equatable.dart';
import 'package:toohak/_toohak.dart';

import '../../helpers/registration_helper.dart';

part 'registration_state.dart';

class RegistrationCubit extends ThCubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationLoadedState());

  final RegistrationHelper _registrationHelper = RegistrationHelper();

  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _registrationHelper.register(
      email: email,
      password: password,
    );
  }
}
