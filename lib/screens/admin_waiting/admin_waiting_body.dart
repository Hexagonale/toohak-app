import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';
import 'package:toohak/screens/admin_waiting/cubit/admin_waiting_cubit.dart';
import 'package:toohak/screens/question/question_screen.dart';

class AdminWaitingBody extends StatefulWidget {
  const AdminWaitingBody({
    super.key,
    required this.state,
    required this.code,
  });

  final AdminWaitingLoadedState state;
  final String code;

  @override
  State<AdminWaitingBody> createState() => _AdminWaitingBodyState();
}

class _AdminWaitingBodyState extends State<AdminWaitingBody> {
  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Toohak',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Game code: ${widget.code}',
                    style: ThTextStyles.headlineH1Bold.copyWith(
                      color: ThColors.textText1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Players count: ${widget.state.nicknames.length}',
                        style: ThTextStyles.headlineH2Semibold.copyWith(
                          color: ThColors.textText1,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      PrimaryButton(
                        title: 'Start game',
                        onTap: () async {
                          if (widget.state.gameTemplate.questions.isEmpty) {
                            return;
                          }

                          DateTime? result = await sl<GameManager>().sendQuestion();

                          if (result != null) {
                            unawaited(thRouter.replace(
                              QuestionScreen.route,
                              arguments: result,
                            ));
                          }
                        },
                        size: ThPrimaryButtonSize.small,
                        style: ThPrimaryButtonStyle.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Wrap(
                    spacing: 24.0,
                    runSpacing: 16.0,
                    children: [
                      for (String player in widget.state.nicknames)
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: ThColors.ascentAscent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            player,
                            style: ThTextStyles.headlineH2Bold.copyWith(
                              color: ThColors.textText1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
