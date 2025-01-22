import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThNumberInput extends StatefulWidget {
  const ThNumberInput({
    super.key,
    this.labelText,
    this.formFieldKey,
    this.onChanged,
    this.focusNode,
    this.controller,
    this.required = false,
    this.maxLines,
    this.minLines,
    this.validator,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.onSubmit,
    this.showDeleteIcon = true,
    this.tooltipMsg,
  });

  final String? labelText;
  final GlobalKey<FormFieldState<String>>? formFieldKey;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool required;
  final int? maxLines;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final void Function()? onSubmit;
  final bool showDeleteIcon;
  final String? tooltipMsg;

  static const OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      color: ThColors.textFormBg,
    ),
  );

  @override
  State<ThNumberInput> createState() => _ThNumberInputState();
}

class _ThNumberInputState extends State<ThNumberInput> {
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
          keyboardType: TextInputType.number,
          initialValue: widget.initialValue,
          minLines: widget.minLines ?? 1,
          maxLines: widget.maxLines ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          enabled: widget.enabled,
          onFieldSubmitted: (String value) => widget.onSubmit?.call(),
          validator: (String? value) {
            if (widget.required && (value == null || value.isEmpty)) {
              return 'Field is required';
            }

            if (widget.validator != null) {
              return widget.validator!(value);
            }

            return null;
          },
          focusNode: widget.focusNode,
          onChanged: (String value) {
            widget.onChanged?.call(value);

            setState(() {});
          },
          key: widget.formFieldKey,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            errorStyle: ThTextStyles.paragraphP3Medium.copyWith(
              color: ThColors.statusColorDanger,
            ),
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
            enabledBorder: ThNumberInput._border,
            focusedBorder: ThNumberInput._border,
            border: ThNumberInput._border,
            focusColor: ThColors.ascentAscent,
            suffixIcon: widget.showDeleteIcon
                ? IconButton(
                    onPressed: () {
                      if (widget.controller != null) {
                        widget.controller!.value = TextEditingValue(
                          text: '',
                          selection: TextSelection.fromPosition(
                            const TextPosition(offset: ''.length),
                          ),
                        );
                      }

                      if (widget.formFieldKey != null) {
                        widget.formFieldKey!.currentState?.didChange(null);
                      }

                      if (widget.onChanged != null) {
                        widget.onChanged!('');
                      }

                      setState(() {});
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: Icon(
                          Icons.cancel,
                          color: ThColors.textText3,
                        ),
                      ),
                    ),
                  )
                : null,
            filled: true,
            alignLabelWithHint: false,
            labelText: widget.labelText,
          ),
        ),
      ),
    );
  }
}
