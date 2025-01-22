import 'package:toohak/_toohak.dart';

class ProfilesDataManager extends DataManager<Profile> {
  final ProfilesDataProvider _profilesDataProvider = sl();
  final Logger _logger = Logger('ProfilesDataManager');

  Profile? dataWithUserId(String userId) => lastKnownValues.firstWhereOrNull(
        (Profile profile) => profile.id == userId,
      );

  Future<bool> fetchWithId(String id) async {
    try {
      final Profile? profile = await _profilesDataProvider.getWithId(id);
      updateStreamWith(<String, Profile?>{id: profile});

      return true;
    } catch (e, stacktrace) {
      _logger.error(
        'fetchWithId, could not fetchWithId',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> createWithId({
    required String id,
    required ProfileWriteRequest profileWriteRequest,
  }) async {
    try {
      await _profilesDataProvider.createWithId(
        id: id,
        profileWriteRequest: profileWriteRequest,
      );

      return fetchWithId(id);
    } catch (e, stacktrace) {
      _logger.error(
        'createWithId, could not create profile',
        error: e,
        stackTrace: stacktrace,
      );

      return false;
    }
  }

  Future<bool> addGameTemplate({
    required String id,
    required String gameTemplateId,
  }) async {
    try {
      await _profilesDataProvider.addGameTemplate(
        id: id,
        gameTemplateId: gameTemplateId,
      );

      await fetchWithId(id);
      return true;
    } catch (error, stacktrace) {
      _logger.error(
        'addGameTemplate, could not add template id: $gameTemplateId to profile id: $id',
        error: error,
        stackTrace: stacktrace,
      );

      return false;
    }
  }
}
