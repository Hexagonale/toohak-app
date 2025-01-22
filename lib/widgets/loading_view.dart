import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: <Widget>[
          LinearProgressIndicator(
            minHeight: 1.5,
            color: ThColors.ascentAscent,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: SizedBox(),
                ),
                Positioned.fill(
                  child: Material(
                    color: ThColors.backgroundBG0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
