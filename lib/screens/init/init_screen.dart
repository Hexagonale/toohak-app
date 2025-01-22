import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/nickname/nickname_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static const String route = '/';

  static final Handler routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const InitScreen();
    },
  );

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final GlobalKey<FormFieldState<String>> _codeKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 350.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Toohak',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ThTextInput(
                    hintText: 'Enter the PIN code',
                    isRequired: true,
                    formFieldKey: _codeKey,
                  ),
                  PrimaryButton(
                    title: 'Join the game',
                    onTap: () {
                      if (_codeKey.currentState!.validate() != true) {
                        return;
                      }

                      final String code = _codeKey.currentState!.value!;
                      thRouter.pushNamed(NicknameScreen.getRoute(code: code));
                    },
                    size: ThPrimaryButtonSize.large,
                    style: ThPrimaryButtonStyle.primary,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you want to create a game?',
                        style: ThTextStyles.headlineH6Regular.copyWith(
                          color: ThColors.textText1,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () async => await appSession.init(),
                        child: Text(
                          'Click here!',
                          style: ThTextStyles.headlineH6Semibold.copyWith(
                            color: ThColors.ascentAscent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
