import '_game_type.dart';

abstract class GameTypeMapper {
  GameTypeMapper._();

  static String getName(GameType gameType) {
    switch (gameType) {
      case GameType.normal:
        return 'Normal';

      case GameType.hardcore:
        return 'Hardcore';
    }
  }

  static GameType? fromName(String gameType) {
    switch (gameType) {
      case 'normal':
        return GameType.normal;

      case 'hardcore':
        return GameType.hardcore;
      default:
        return null;
    }
  }
}
