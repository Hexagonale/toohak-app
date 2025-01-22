import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toohak/_toohak.dart';

part 'login_state.dart';

class LoginCubit extends ThCubit<LoginState> {
  LoginCubit() : super(LoginLoadedState());

  final AuthManager _authManager = sl();
  final FirebaseAuth _firebaseAuth = sl();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    BotToast.showLoading();
    final bool result = await _authManager.login(
      email: email,
      password: password,
    );
    if (!result) {
      BotToast.closeAllLoading();
      return;
    }

    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      return;
    }

    await appSession.init();

    if (!appSession.isValid) {
      return;
    }

    BotToast.closeAllLoading();
  }
}
