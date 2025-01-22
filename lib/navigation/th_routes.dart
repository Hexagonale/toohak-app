import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/admin/admin_screen.dart';
import 'package:toohak/screens/admin_waiting/admin_waiting_screen.dart';
import 'package:toohak/screens/after_answer_waiting/after_answer_waiting_screen.dart';
import 'package:toohak/screens/answer/answer_screen.dart';
import 'package:toohak/screens/auth/login/login_screen.dart';
import 'package:toohak/screens/auth/registration/registration_screen.dart';
import 'package:toohak/screens/final_ranking/final_ranking_screen.dart';
import 'package:toohak/screens/game_over/game_over_screen.dart';
import 'package:toohak/screens/init/init_screen.dart';
import 'package:toohak/screens/nickname/nickname_screen.dart';
import 'package:toohak/screens/player_waiting/player_waiting_screen.dart';
import 'package:toohak/screens/question/question_screen.dart';
import 'package:toohak/screens/result/result_screen.dart';
import 'package:toohak/screens/round_ranking/round_ranking_screen.dart';
import 'package:toohak/screens/template_details/template_details_screen.dart';

class ThRoutes {
  const ThRoutes();

  static final List<ThRoute> allRoutes = <ThRoute>[
    init,
    admin,
    templateDetails,
    registration,
    login,
    nickname,
    playerWaiting,
    adminWaiting,
    answer,
    question,
    afterAnswerWaiting,
    roundRanking,
    finalRanking,
    result,
    gameOver,
  ];

  static String getUniversalRouteName(String routeName) {
    final List<String> parts = routeName.split('/');
    if (parts.isEmpty) {
      return routeName;
    }

    if (parts.last.startsWith(':')) {
      parts.removeLast();
    }

    return parts.join('/');
  }

  static const String dialogRouteName = '/dialog';

  static final ThRoute answer = ThRoute(
    route: '/answer/:game-id',
    handler: AnswerScreen.routeHandler,
  );

  static final ThRoute adminWaiting = ThRoute(
    route: '/admin-waiting/:code',
    handler: AdminWaitingScreen.routeHandler,
  );

  static final ThRoute templateDetails = ThRoute(
    route: '/templates/:id',
    handler: TemplateDetailsScreen.routeHandler,
  );

  static final ThRoute nickname = ThRoute(
    route: '/nickname/:code',
    handler: NicknameScreen.routeHandler,
  );

  static final ThRoute init = ThRoute(
    route: InitScreen.route,
    handler: InitScreen.routeHandler,
  );

  static final ThRoute admin = ThRoute(
    route: AdminScreen.route,
    handler: AdminScreen.routeHandler,
  );

  static final ThRoute registration = ThRoute(
    route: RegistrationScreen.route,
    handler: RegistrationScreen.routeHandler,
  );

  static final ThRoute roundRanking = ThRoute(
    route: RoundRankingScreen.route,
    handler: RoundRankingScreen.routeHandler,
  );
  static final ThRoute finalRanking = ThRoute(
    route: FinalRankingScreen.route,
    handler: FinalRankingScreen.routeHandler,
  );

  static final ThRoute question = ThRoute(
    route: QuestionScreen.route,
    handler: QuestionScreen.routeHandler,
  );

  static final ThRoute result = ThRoute(
    route: ResultScreen.route,
    handler: ResultScreen.routeHandler,
  );

  static final ThRoute playerWaiting = ThRoute(
    route: PlayerWaitingScreen.route,
    handler: PlayerWaitingScreen.routeHandler,
  );

  static final ThRoute afterAnswerWaiting = ThRoute(
    route: AfterAnswerWaitingScreen.route,
    handler: AfterAnswerWaitingScreen.routeHandler,
  );

  static final ThRoute gameOver = ThRoute(
    route: GameOverScreen.route,
    handler: GameOverScreen.routeHandler,
  );

  static final ThRoute login = ThRoute(
    route: LoginScreen.route,
    handler: LoginScreen.routeHandler,
  );
}
