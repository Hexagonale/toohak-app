import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TimerBuilder extends StatefulWidget {
  const TimerBuilder({
    super.key,
    required this.builder,
    required this.endTime,
  });

  final Widget Function(BuildContext context, Duration duration) builder;
  final DateTime endTime;

  @override
  State<TimerBuilder> createState() => _TimerBuilderState();
}

class _TimerBuilderState extends State<TimerBuilder> with SingleTickerProviderStateMixin {
  Ticker? _ticker;

  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      setState(() {});
    });

    _ticker?.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker?.stop();
    _ticker?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.endTime.difference(DateTime.now());

    return widget.builder(context, duration);
  }
}
