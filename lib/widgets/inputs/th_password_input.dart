import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThPasswordInput extends StatefulWidget {
  const ThPasswordInput({
    super.key,
    this.labelText,
    this.hintText,
    this.formFieldKey,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.required = false,
    this.validator,
    this.enabled = true,
    this.onSubmit,
    this.autofillHints,
  });

  final String? labelText;
  final String? hintText;
  final GlobalKey<FormFieldState<String>>? formFieldKey;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool required;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final void Function()? onSubmit;
  final List<String>? autofillHints;

  @override
  State<ThPasswordInput> createState() => _ThPasswordInputState();
}

class _ThPasswordInputState extends State<ThPasswordInput> {
  bool _passwordNotVisible = true;

  static const OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      color: ThColors.textFormBg,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: 70.0,
        child: TextFormField(
          style: ThTextStyles.textCategory.copyWith(
            color: ThColors.textText2,
          ),
          autofillHints: widget.autofillHints,
          maxLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          enabled: widget.enabled,
          onFieldSubmitted: (String value) => widget.onSubmit?.call(),
          validator: (String? value) {
            if (widget.required && (value == null || value.isEmpty)) {
              return 'Required field';
            }

            if (widget.validator != null) {
              return widget.validator!(value);
            }

            return null;
          },
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          key: widget.formFieldKey,
          obscureText: _passwordNotVisible,
          decoration: InputDecoration(
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
            fillColor: ThColors.textFormBg,
            hintStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText4,
            ),
            labelStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText4,
            ),
            floatingLabelStyle: ThTextStyles.textCategory.copyWith(
              color: ThColors.textText4,
            ),
            enabledBorder: _border,
            focusedBorder: _border,
            border: _border,
            focusColor: ThColors.ascentAscent,
            contentPadding: const EdgeInsets.all(16.0),
            hintText: widget.hintText,
            errorStyle: ThTextStyles.paragraphP3Medium.copyWith(
              color: ThColors.statusColorDanger,
            ),
            filled: true,
            alignLabelWithHint: false,
            labelText: widget.labelText,
            suffixIcon: IconButton(
              icon: _passwordNotVisible
                  ? const Icon(
                      Icons.visibility_off_outlined,
                      color: ThColors.textText4,
                    )
                  : const Icon(
                      Icons.visibility_outlined,
                      color: ThColors.textText4,
                    ),
              onPressed: () {
                setState(() {
                  _passwordNotVisible = !_passwordNotVisible;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
