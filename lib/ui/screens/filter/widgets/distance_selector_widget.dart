import 'package:flutter/material.dart';
import 'package:places/constants/strings_const.dart';
import 'package:places/utils/debouncer.dart';

class DistanceSelectorWidget extends StatefulWidget {
  ///инициализация диапазона
  final RangeValues currentRange;

  ///минимально и максимально доступные для выбора значения диапазона
  final RangeValues availableRange;

  /// callback вызивается при изменении диапазона
  final void Function(RangeValues range) onDistanceChange;

  /// задержка вызова [onDistanceChange]. т.к. при перемещении ползунка слайдера может идти слишком частый вызов [onDistanceChange]
  final Duration debounce;

  const DistanceSelectorWidget({
    Key? key,
    required this.onDistanceChange,
    this.currentRange = const RangeValues(0.0, 30.0),
    this.availableRange = const RangeValues(0.0, 30.0),
    this.debounce = const Duration(milliseconds: 50),
  }) : super(key: key);

  @override
  State<DistanceSelectorWidget> createState() => _DistanceSelectorWidgetState();
}

class _DistanceSelectorWidgetState extends State<DistanceSelectorWidget> {
  late RangeValues _currentRangeValues = widget.currentRange;

  late final _debounce = Debouncer(duration: widget.debounce);
  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(AppStrings.filterDistance),
            Spacer(),
            Text(_rangeText),
          ],
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.availableRange.start,
          max: widget.availableRange.end,
          labels: RangeLabels(
            _currStart,
            _currEnd,
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              onSelectedRangeWithDebounce(values);
            });
          },
        )
      ],
    );
  }

  String get _rangeText =>
      '${AppStrings.filterFrom} $_currStart ${AppStrings.filterTo} $_currEnd ${AppStrings.filterKm}';
  String get _currStart => _currentRangeValues.start.round().toString();
  String get _currEnd => _currentRangeValues.end.round().toString();

  void onSelectedRangeWithDebounce(RangeValues values) {
    _debounce.run(() {
      widget.onDistanceChange(values);
    });
  }
}
