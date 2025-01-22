import 'package:chalk/chalk.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toohak/_toohak.dart';

class LoggerInstance {
  factory LoggerInstance() {
    return _instance ??= LoggerInstance._();
  }

  LoggerInstance._();

  static LoggerInstance? _instance;
  final PublishSubject<UserError?> _userErrorState$ = PublishSubject<UserError?>();

  Stream<UserError?> get userErrorState {
    return _userErrorState$;
  }

  Future<void> dispose() async {
    await _userErrorState$.close();
  }

  void log({
    required LoggerLevel level,
    required String tag,
    required String message,
    required Object? error,
    required StackTrace? stackTrace,
    UserError? userError,
  }) {
    if (userError != null) {
      _userErrorState$.add(userError);
    }

    final String date = DateTime.now().readableTime;
    message = '$date [$tag] $message';

    if (error != null) {
      message += '\nerror: $error';
    }

    if (stackTrace != null) {
      message += '\nstackTrace: $stackTrace';
    }

    switch (level) {
      case LoggerLevel.error:
        // ignore: avoid_print
        print(chalk.red(message));
        break;
      case LoggerLevel.warning:
        // ignore: avoid_print
        print(chalk.yellow(message));
        break;
      case LoggerLevel.info:
        // ignore: avoid_print
        print(chalk.blue(message));
    }
  }
}
