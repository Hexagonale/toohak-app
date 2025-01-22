import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.size,
    required this.style,
    this.secondaryTextColor,
    this.icon,
  });

  final String title;
  final void Function()? onTap;
  final ThPrimaryButtonSize size;
  final ThPrimaryButtonStyle style;
  final Color? secondaryTextColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (style == ThPrimaryButtonStyle.justText) {
      return _buildJustText(context);
    }

    return Material(
      borderRadius: _borderRadius,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: onTap,
        splashColor: Colors.white.withValues(alpha: 0.0),
        child: Ink(
          height: size == ThPrimaryButtonSize.large ? 50.0 : null,
          width: size == ThPrimaryButtonSize.large ? double.maxFinite : null,
          decoration: _getShapeDecoration(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 26.0,
                vertical: 6.0,
              ),
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (icon == null) {
      return Text(
        title,
        style: ThTextStyles.textButtonBig.copyWith(
          color: _getTextColor(context),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        const SizedBox(width: 5.0),
        Text(
          title,
          style: ThTextStyles.textButtonBig.copyWith(
            color: _getTextColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildJustText(BuildContext context) {
    if (size == ThPrimaryButtonSize.large) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 50.0,
          child: Row(
            children: [
              const Expanded(
                child: SizedBox(width: double.maxFinite),
              ),
              Text(
                title,
                style: ThTextStyles.textButtonBig.copyWith(
                  color: secondaryTextColor ?? ThColors.elementsButtonSecondaryText,
                ),
              ),
              const Expanded(
                child: SizedBox(width: double.maxFinite),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 26.0,
          vertical: 6.0,
        ),
        child: Text(
          title,
          style: ThTextStyles.textButtonBig.copyWith(
            color: secondaryTextColor ?? ThColors.elementsButtonSecondaryText,
          ),
        ),
      ),
    );
  }

  BoxDecoration _getShapeDecoration(BuildContext context) {
    if (style == ThPrimaryButtonStyle.primary) {
      return BoxDecoration(
        borderRadius: _borderRadius,
        gradient: ThColors.lightElementsButtonPrimaryActiveBackground,
      );
    }

    if (style == ThPrimaryButtonStyle.secondary) {
      return BoxDecoration(
        borderRadius: _borderRadius,
        color: ThColors.elementsButtonSecondaryBackground,
      );
    }

    return BoxDecoration(
      borderRadius: _borderRadius,
      color: ThColors.elementsButtonSecondaryBackground,
    );
  }

  Color _getTextColor(BuildContext context) {
    if (style == ThPrimaryButtonStyle.primary) {
      return ThColors.textText1;
    }

    if (style == ThPrimaryButtonStyle.secondary) {
      if (secondaryTextColor != null) {
        return secondaryTextColor!;
      }

      return ThColors.elementsButtonSecondaryText;
    }

    return ThColors.textText3;
  }

  BorderRadius get _borderRadius =>
      size == ThPrimaryButtonSize.large ? BorderRadius.circular(12.0) : BorderRadius.circular(8.0);
}
