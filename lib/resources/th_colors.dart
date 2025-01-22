import 'package:flutter/material.dart';

abstract class ThColors {
  ThColors._();

  static const Color ascentAscent = Color(0xff102475);

  static const Color textText1 = Colors.white;
  static const Color textText2 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color textText3 = Color.fromRGBO(255, 255, 255, 0.5);
  static const Color textText4 = Color(0xffa8bac4);
  static const Color textText5 = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color highlightColorLightGreyGreenShade = Color(0xff3b4338);

  static const Color statusColorSuccess = Color(0xff82E282);
  static const Color statusColorInfo = Color(0xff48b5f7);
  static const Color statusColorWarning = Color(0xfff1dd77);
  static const Color statusColorDanger = Color(0xffe38c87);
  static const Color statusColorDangerDark = Color(0xFFFF4867);

  static const Color backgroundBG0 = Color(0xff4456A0);
  static const Color backgroundBG1 = Color(0xff6979BA);
  static const Color backgroundBG2 = Color(0xff9AABEF);
  static const Color textFormBg = Color.fromRGBO(255, 255, 255, 0.05);

  static const Color elementsButtonSecondaryBackground = Color.fromRGBO(255, 255, 255, 0.098);
  static const Color elementsButtonSecondaryText = Colors.white;

  static const LinearGradient lightElementsButtonPrimaryActiveBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFE6954),
      Color(0xFFFF4867),
    ],
  );

  static const List<Color> answerColors = [
    Color(0xffF19C60),
    Color(0xff8c7cca),
    Color(0xff6a98dc),
    Color(0xff3DD174),
    Color(0xFFFF4867),
    Color(0xff4456A0),
  ];
}
