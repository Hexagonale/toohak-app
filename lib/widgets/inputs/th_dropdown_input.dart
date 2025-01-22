import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toohak/_toohak.dart';

class ThDropdownInput<T> extends StatefulWidget {
  const ThDropdownInput({
    Key? key,
    required this.values,
    required this.label,
    this.formFieldKey,
    this.initialValue,
    this.onChanged,
    this.customSorting,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
    this.translateItemToString,
    this.translateItemToSubtitle,
  }) : super(key: key);

  final void Function(T? value)? onChanged;
  final String Function(T? element)? translateItemToString;
  final void Function(List<T> elements)? customSorting;
  final Set<T> values;
  final String label;
  final T? initialValue;
  final bool isRequired;
  final bool enabled;
  final GlobalKey<FormFieldState<T>>? formFieldKey;
  final FormFieldValidator<T>? validator;
  final String Function(T? element)? translateItemToSubtitle;

  @override
  State<ThDropdownInput<T>> createState() => _ThDropdownInputState<T>();
}

class _ThDropdownInputState<T> extends State<ThDropdownInput<T>> with TickerProviderStateMixin {
  final GlobalKey<RawGestureDetectorState> _globalKey = GlobalKey<RawGestureDetectorState>();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _expandAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  );
  late T? _selectedItem = widget.initialValue;
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: FormField<T>(
        enabled: widget.enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: widget.formFieldKey,
        validator: (T? value) {
          if (widget.isRequired && (value == null || value == false)) {
            return 'Required field';
          }

          if (widget.validator != null) {
            return widget.validator!(value);
          }

          return null;
        },
        initialValue: widget.initialValue,
        builder: (FormFieldState<T> field) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _buildContent(field),
            ),
            _buildErrorLine(field),
          ],
        ),
      ),
    );
  }

  void setValue(T value) {
    _selectedItem = value;
  }

  T? get value {
    return _selectedItem;
  }

  Widget _buildErrorLine(FormFieldState<T> field) {
    if (field.hasError) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
        ),
        child: Text(
          field.errorText!,
          style: ThTextStyles.paragraphP3Medium.copyWith(
            color: ThColors.statusColorDanger,
          ),
        ),
      );
    }

    if (ThTextStyles.paragraphP3Medium.fontSize == null) {
      return const SizedBox(height: 14.0);
    }

    return SizedBox(height: ThTextStyles.paragraphP3Medium.fontSize! + 1.0);
  }

  Widget _buildContent(FormFieldState<T> field) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child: GestureDetector(
            key: _globalKey,
            onTap: () => widget.enabled ? _toggleDropdown(_globalKey.currentContext ?? context, field) : null,
            child: _buildDropDown(field),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.5, left: 8.0),
          child: Container(
            color: ThColors.backgroundBG1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                width: widget.label
                    .textSize(
                      ThTextStyles.textCategory.copyWith(
                        color: ThColors.textText1,
                      ),
                    )
                    .width,
                height: 2,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 2.0,
          ),
          child: Text(
            widget.label,
            style: _getLabelTextStyle(field),
          ),
        ),
      ],
    );
  }

  Widget _buildDropDown(FormFieldState<T> field) {
    return Container(
      height: 52,
      decoration: _getDropdownDecoration(field),
      child: CompositedTransformTarget(
        link: this._layerLink,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              field.value == null
                  ? const SizedBox()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Text(
                          _getName(field.value),
                          style: ThTextStyles.textCategory.copyWith(
                            color: ThColors.textText1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
              _buildDropdownSuffix(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownSuffix() {
    return _isOpen
        ? const Icon(
            Icons.expand_less,
            color: ThColors.textText3,
          )
        : const Icon(
            Icons.expand_more,
            color: ThColors.textText3,
          );
  }

  OverlayEntry _createOverlayEntry(BuildContext widgetContext, FormFieldState<T> field) {
    final RenderBox? renderBox = widgetContext.findRenderObject() as RenderBox?;
    final Size size = renderBox?.size ?? const Size(0, 0);

    final Offset offset = renderBox?.localToGlobal(Offset.zero) ?? const Offset(0, 0);

    final double dropdownBottomHeight = offset.dy + size.height;
    final double availableSafeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - dropdownBottomHeight - 16.0;

    final double maxHeight = min(availableSafeHeight, MediaQuery.of(context).size.height / 2);

    return OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        onTap: () => _toggleDropdown(widgetContext, field, close: true),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: CompositedTransformFollower(
                offset: Offset(0, size.height),
                link: _layerLink,
                showWhenUnlinked: false,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 6,
                        spreadRadius: 2,
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                      ),
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.zero,
                    color: ThColors.backgroundBG2,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: maxHeight,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.values.map((T item) {
                            final ValueNotifier<bool> isHovered = ValueNotifier<bool>(false);

                            return GestureDetector(
                              onTap: () {
                                _itemChange(item, field);

                                _overlayEntry.markNeedsBuild();
                                _toggleDropdown(widgetContext, field, close: true);
                                setState(() {});
                              },
                              child: MouseRegion(
                                onEnter: (_) {
                                  isHovered.value = true;
                                },
                                onExit: (_) {
                                  isHovered.value = false;
                                },
                                child: ValueListenableBuilder<bool>(
                                  valueListenable: isHovered,
                                  builder: (_, bool isHovered, __) => Container(
                                    color: Colors.black.withValues(alpha: 0.0),
                                    height: widget.translateItemToSubtitle == null ? 40 : 85,
                                    width: double.minPositive,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: widget.translateItemToSubtitle == null
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                _getName(item),
                                                style: ThTextStyles.paragraphP3Medium.copyWith(
                                                  color: ThColors.textText1,
                                                ),
                                              ),
                                            )
                                          : ListTile(
                                              title: Text(
                                                _getName(item),
                                                style: ThTextStyles.paragraphP3Medium.copyWith(
                                                  color: ThColors.textText1,
                                                ),
                                              ),
                                              subtitle: Text(
                                                _getSubtitle(item),
                                                style: ThTextStyles.paragraphP3Medium.copyWith(
                                                  color: ThColors.textText1,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getName(T? e) {
    if (widget.translateItemToString == null) {
      return e.toString();
    }
    return widget.translateItemToString!(e);
  }

  String _getSubtitle(T? e) {
    if (widget.translateItemToSubtitle == null) {
      return e.toString();
    }
    return widget.translateItemToSubtitle!(e);
  }

  TextStyle _getLabelTextStyle(FormFieldState<T> field) {
    if (field.hasError) {
      return ThTextStyles.textCategory
          .copyWith(
            color: ThColors.textText1,
          )
          .copyWith(
            color: const Color(0xffF14564),
          );
    }

    return ThTextStyles.textCategory.copyWith(
      color: ThColors.textText1,
    );
  }

  BoxDecoration? _getDropdownDecoration(FormFieldState<T> field) {
    BoxDecoration dropdownDecoration = BoxDecoration(
      color: ThColors.backgroundBG1,
      border: Border.all(
        color: ThColors.textText5,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    if (field.hasError) {
      return dropdownDecoration.copyWith(
        border: Border.all(
          color: const Color(0xffF14564),
        ),
      );
    }

    return dropdownDecoration;
  }

  void _itemChange(T itemValue, FormFieldState<T> field) {
    field.didChange(itemValue);
    widget.onChanged?.call(itemValue);

    setState(() {});
  }

  void _toggleDropdown(BuildContext widgetContext, FormFieldState<T> field, {bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();

      _isOpen = false;
      setState(() {});
    } else {
      _overlayEntry = _createOverlayEntry(widgetContext, field);
      Overlay.of(context).insert(_overlayEntry);

      _isOpen = true;
      setState(() {});

      unawaited(_animationController.forward());
    }
  }
}
