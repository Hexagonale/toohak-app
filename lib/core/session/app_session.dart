import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toohak/_toohak.dart';

final AppSession appSession = AppSession.instance;

class AppSession {
  static AppSession get instance => sl();

  final AuthManager _authManager = sl();
  final FirebaseAuth _firebaseAuth = sl();
  final ProfilesDataManager _profileManager = sl();

  final BehaviorSubject<CurrentAppSession?> _currentAppSession$ = BehaviorSubject<CurrentAppSession?>.seeded(null);

  User? get currentUser => FirebaseAuth.instance.currentUser;

  StreamSubscription<dynamic>? _firebaseSession;

  bool get isValid => _currentAppSession$.value != null;

  final Logger _logger = Logger('AppSession');

  Future<void> init() async {
    _firebaseSession ??= _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        _currentAppSession$.add(null);
        thRouter.pushNamed(ThRoutes.login.route);
        _logger.info('init, user is null');
      }
    });

    final String? userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      unawaited(thRouter.pushNamed(ThRoutes.login.route));
      return;
    }

    await _profileManager.fetchWithId(userId);
    final Profile? profile = _profileManager.lastKnownValueForId(userId);
    bool result = true;

    if (profile == null) {
      result = await _authManager.createOrReplaceProfile();
    }

    if (!result) {
      unawaited(thRouter.pushNamed(ThRoutes.login.route));
      _logger.error('init, could not create profile');

      return;
    }

    _currentAppSession$.add(
      CurrentAppSession(
        profile: profile!,
        user: _firebaseAuth.currentUser!,
      ),
    );
    unawaited(thRouter.removeAllAndPush(ThRoutes.admin.route));
    _logger.info('init, profile is valid');
  }

  Future<void> signOut() async {
    _currentAppSession$.add(null);
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }
  }
}
