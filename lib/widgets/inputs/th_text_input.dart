import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toohak/_toohak.dart';

class ThTextInput extends StatelessWidget {
  const ThTextInput({
    super.key,
    this.labelText,
    this.hintText,
    this.formFieldKey,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.isRequired = false,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.loading = false,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.onSubmit,
    this.autofillHints,
    this.withoutSpaces = false,
    this.suffixText,
    this.fillColor = ThColors.backgroundBG1,
    this.textColor = ThColors.textText1,
  });

  final String? labelText;
  final String? hintText;
  final GlobalKey<FormFieldState<String>>? formFieldKey;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool isRequired;
  final bool loading;
  final int? maxLines;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final void Function()? onSubmit;
  final List<String>? autofillHints;
  final bool withoutSpaces;
  final String? suffixText;
  final Color fillColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 70.0,
        child: TextFormField(
          style: ThTextStyles.textCategory.copyWith(
            color: textColor,
          ),
          autofillHints: autofillHints,
          keyboardType: TextInputType.multiline,
          initialValue: initialValue,
          minLines: minLines ?? 1,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          enabled: enabled,
          onFieldSubmitted: (String value) => onSubmit?.call(),
          validator: (String? value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Required field';
            }

            if (validator != null) {
              return validator!(value);
            }

            return null;
          },
          focusNode: focusNode,
          onChanged: onChanged,
          key: formFieldKey,
          obscureText: obscureText,
          inputFormatters: withoutSpaces
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ]
              : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            errorStyle: ThTextStyles.paragraphP3Medium.copyWith(
              color: ThColors.statusColorDanger,
            ),
            suffixText: suffixText,
            hintText: hintText,
            focusColor: ThColors.ascentAscent,
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: ThColors.statusColorDanger,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: ThColors.statusColorDanger,
              ),
            ),
            filled: true,
            fillColor: fillColor,
            alignLabelWithHint: false,
            labelText: labelText,
            hintStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText4,
            ),
            labelStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText4,
            ),
            floatingLabelStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText1,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: ThColors.textFormBg,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: ThColors.textFormBg,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(
                color: ThColors.textFormBg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
