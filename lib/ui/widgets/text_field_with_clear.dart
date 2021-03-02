import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Текстовое поле с кнопкой очистки
///
/// кнопка "очистить" видна если в TextField есть контент и он в фокусе
/// [onSubmitted] вызывается когда пользователь закончил ввод
/// [onTap] при нажатии на поле
/// [onClear] вызывается когда поле очищается
/// [onChanged] при изменении поля
/// [controller] и [focusNode] можно передать из вне или они создаются на месте
class TextFieldWithClear extends StatefulWidget {
  final String text;
  final String hintText;
  final int maxLines;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool autoFocus;
  final Widget prefixIcon;

  const TextFieldWithClear({
    Key key,
    this.focusNode,
    this.controller,
    this.onSubmitted,
    this.maxLines = 1,
    this.textInputAction,
    this.keyboardType,
    this.text,
    this.hintText,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.onChanged,
    this.onClear,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  _TextFieldWithClearState createState() => _TextFieldWithClearState();
}

class _TextFieldWithClearState extends State<TextFieldWithClear> {
  TextEditingController _controller;
  FocusNode _focusNode;

  // Видна ли кнопка очистки текста
  bool _isClearVisible;

  @override
  void initState() {
    super.initState();
    // Если контроллер и focusNode не передали, то создаем его тут,
    // а в dispose закрываем
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _controller.text = widget.text;
    _updateClearVisibility();
    _focusNode.addListener(_updateClearVisibility);
  }

  @override
  Widget build(BuildContext context) {
    final clearBtnDecoration = InputDecoration(
      suffixIcon: InkWell(
        onTap: _onClearTap,
        child: const Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SvgIcon(icon: SvgIcons.clear),
          ),
        ),
      ),
      suffixIconConstraints: const BoxConstraints(),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: widget.prefixIcon,
      ),
      prefixIconConstraints: const BoxConstraints(),
    );

    final decoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: widget.prefixIcon,
      ),
      prefixIconConstraints: const BoxConstraints(),
    );

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: widget.autoFocus,
      decoration: _isClearVisible ? clearBtnDecoration : decoration,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      onChanged: (value) => _onChanged(value),
      onSubmitted: (value) => widget.onSubmitted?.call(value),
      onTap: () => widget.onTap?.call(),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateClearVisibility);
    // Если контроллер не передали из вне,
    // то тогда он был создан тут и надо его закрыть
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value) {
    _updateClearVisibility();
    widget.onChanged?.call(value);
  }

  void _updateClearVisibility() {
    setState(() {
      _isClearVisible = _controller.text != '' && _focusNode.hasPrimaryFocus;
    });
  }

  void _onClearTap() {
    _controller.clear();
    _updateClearVisibility();
    widget.onChanged?.call(_controller.text);
    widget.onClear?.call();
  }
}
