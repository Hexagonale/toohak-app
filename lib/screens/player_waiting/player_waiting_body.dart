import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class PlayerWaitingBody extends StatefulWidget {
  const PlayerWaitingBody({super.key});

  @override
  State<PlayerWaitingBody> createState() => _PlayerWaitingBodyState();
}

class _PlayerWaitingBodyState extends State<PlayerWaitingBody> {
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
                  'Got it! Check your nickname on the screen!',
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
