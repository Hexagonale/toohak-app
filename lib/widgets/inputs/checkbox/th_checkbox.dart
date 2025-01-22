import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThCheckbox extends StatefulWidget {
  const ThCheckbox({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  State<ThCheckbox> createState() => _ThCheckboxState();
}

class _ThCheckboxState extends State<ThCheckbox> {
  late bool _isSelected = widget.value;

  @override
  void didUpdateWidget(covariant ThCheckbox oldWidget) {
    _isSelected = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      value: _isSelected,
      activeColor: ThColors.ascentAscent,
      side: const BorderSide(
        color: ThColors.textText5,
        width: 2.0,
      ),
      checkColor: Colors.white,
      onChanged: (bool? value) {
        _isSelected = !_isSelected;
        widget.onChanged?.call(_isSelected);
        setState(() {});
      },
    );
  }
}
