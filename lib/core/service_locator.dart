import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:toohak/_toohak.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerSingleton(FirebaseFirestore.instance);
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton(FirebaseFunctions.instance);
  sl.registerSingleton(ThRouter()..init(ThRoutes.allRoutes));

  //data providers
  sl.registerFactory(() => GameTemplateDataProvider());
  sl.registerFactory(() => GameDataProvider());
  sl.registerFactory(() => MyAuthProvider());
  sl.registerFactory(() => ProfilesDataProvider());
  sl.registerFactory(() => FunctionsDataProvider());

  //data managers
  sl.registerLazySingleton(() => NavigationManager());
  sl.registerLazySingleton(() => GameTemplateDataManager());
  sl.registerLazySingleton(() => GameDataManager());
  sl.registerLazySingleton(() => AuthManager());
  sl.registerLazySingleton(() => ProfilesDataManager());

  // managers
  await _registerManagers();

  //app session
  sl.registerSingleton(AppSession());
}

Future<bool> _registerManagers() async {
  // region CloudEventsManager

  CloudEventsManager cloudEventsManager = CloudEventsManager();
  final bool cloudEventsSuccess = await cloudEventsManager.init();
  if (!cloudEventsSuccess) {
    // Logger
    return false;
  }

  sl.registerSingleton(cloudEventsManager);

  // endregion

  // region PlayersManager

  PlayersManager playersManager = PlayersManager(
    cloudEventsManager: cloudEventsManager,
  );
  final bool playersSuccess = await playersManager.init();
  if (!playersSuccess) {
    // Logger
    return false;
  }

  sl.registerSingleton(playersManager);

  // endregion

  // region CloudFunctionsManager
  FunctionsManager cloudFunctionsManager = FunctionsManager();

  sl.registerSingleton(cloudFunctionsManager);

  // endregion

  // region GameManager
  GameManager questionManager = GameManager(
    cloudFunctionsManager: cloudFunctionsManager,
  );

  final bool questionSuccess = await questionManager.init();
  if (!questionSuccess) {
    // Logger
    return false;
  }

  sl.registerSingleton(questionManager);

  return true;
  // endregion
}
