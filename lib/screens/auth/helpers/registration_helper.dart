import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toohak/_toohak.dart';

class RegistrationHelper {
  RegistrationHelper();

  final AuthManager _authManager = sl();
  final FirebaseAuth _firebaseAuth = sl();

  Future<void> register({
    required String email,
    required String password,
  }) async {
    BotToast.showLoading();
    final bool registerResult = await _authManager.register(
      email: email,
      password: password,
    );
    if (!registerResult) {
      BotToast.closeAllLoading();
      return;
    }

    final bool loginResult = await _authManager.login(
      email: email,
      password: password,
    );
    if (!loginResult) {
      BotToast.closeAllLoading();
      return;
    }

    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      BotToast.closeAllLoading();
      return;
    }
    bool result = await _authManager.createOrReplaceProfile();
    if (!result) {
      BotToast.closeAllLoading();
      return;
    }

    await appSession.init();

    BotToast.closeAllLoading();
  }
}
