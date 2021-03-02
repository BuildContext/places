import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';

/// Функция показывает CupertinoDatePicker с кнопкой подтверждения на BottomSheet
Future<DateTime> showIosDatePicker({
  BuildContext context,
  DateTime initialDate,
  DateTime firstDate,
  DateTime lastDate,
}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => _IosDatePicker(
      firstDate: firstDate,
      lastDate: lastDate,
    ),
  );
}

// Виджет рисует CupertinoDatePicker с кнопкой
class _IosDatePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;

  const _IosDatePicker({
    Key key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
  }) : super(key: key);

  @override
  _IosDatePickerState createState() => _IosDatePickerState();
}

class _IosDatePickerState extends State<_IosDatePicker> {
  DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.firstDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) => date = value,
              initialDateTime: widget.initialDate,
              minimumDate: widget.firstDate,
              minimumYear: widget.firstDate.year,
              maximumDate: widget.lastDate,
              maximumYear: widget.lastDate.year,
            ),
          ),
          CupertinoButton(
            onPressed: () => Navigator.of(context).pop(date),
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }
}
