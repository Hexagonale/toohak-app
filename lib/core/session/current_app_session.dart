import 'package:firebase_auth/firebase_auth.dart';
import 'package:toohak/_toohak.dart';

class CurrentAppSession {
  const CurrentAppSession({
    required this.profile,
    required this.user,
  });

  final Profile profile;
  final User user;
}
