import 'package:firebase_auth/firebase_auth.dart';
import 'package:toohak/_toohak.dart';

class AuthManager {
  final MyAuthProvider _authDataProvider = sl();
  final FirebaseAuth _firebaseAuth = sl();
  final ProfilesDataManager _profilesDataManager = sl();

  final Logger _logger = Logger('AuthManager');

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await _authDataProvider.login(
        email: email,
        password: password,
      );

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'login, error',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      await _authDataProvider.register(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    } catch (e, stacktrace) {
      _logger.error(
        'register, error',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> createOrReplaceProfile() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }

      await _profilesDataManager.createWithId(
        id: user.uid,
        profileWriteRequest: const ProfileWriteRequest(
          gameTemplateIds: <String>[],
        ),
      );

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'createProfileIfNotExist, error',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }
}
