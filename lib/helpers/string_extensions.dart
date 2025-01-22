import 'package:flutter/material.dart';

extension StringExtensions<T extends String> on T {
  Size textSize(TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: style,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );

    return textPainter.size;
  }
}
