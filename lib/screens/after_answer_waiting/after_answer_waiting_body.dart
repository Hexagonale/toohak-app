import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class AfterAnswerWaitingBody extends StatefulWidget {
  const AfterAnswerWaitingBody({super.key});

  @override
  State<AfterAnswerWaitingBody> createState() => _AfterAnswerWaitingBodyState();
}

class _AfterAnswerWaitingBodyState extends State<AfterAnswerWaitingBody> {

  @override
  Widget build(BuildContext context) {
    return ThAppScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
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
               Text(
                  'Genius? Wait for the result!',
                  style: ThTextStyles.headlineH1Bold.copyWith(
                    color: ThColors.textText1,
                  ),
                  textAlign: TextAlign.center,
                ),
               
                const SizedBox(height: 24.0),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
