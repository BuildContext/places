import 'package:flutter/material.dart';
import 'package:places/domain/sight_type/default_sight_types.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';

/// Экран выбора категории
class SelectCategoryScreen extends StatefulWidget {
  static const String routeName = 'SelectCategoryScreen';

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  // список категорий
  final List<SightType> _types = defaultSightTypes;

  // Индекс выбранной категории. -1 означает ничего не выбрано.
  int _selectedIndex = -1;

  // Доступность кнопки submit
  bool _isSubmitEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.selectCategoryAppbarTitle),
        leading: IconTextButton(
          icon: SvgIcons.arrowLeft,
          onPressed: _onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Отступ  снизу, чтобы скролл под кнопку не забирался.
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ListView.separated(
                itemCount: _types.length,
                itemBuilder: _buildItem,
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),

            // Кнопка "сохранить" всегда прижата к низу.
            Align(
              alignment: Alignment.bottomCenter,
              child: IconElevatedButton(
                text: AppStrings.selectCategoryBtnSave,
                onPressed: _isSubmitEnabled ? _onSubmit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    // галочка только у выбранного элемента
    final Widget trailing = _selectedIndex == index
        ? SvgIcon(
            icon: SvgIcons.tick,
            color: Theme.of(context).accentColor,
          )
        : null;

    return ListTile(
      title: Text(_types[index].name),
      trailing: trailing,
      onTap: () => _onSelectItem(index),
    );
  }

  // Нажатие на элемент.
  void _onSelectItem(int index) {
    setState(() {
      // Выбираем или отменяем выбор.
      _selectedIndex = index != _selectedIndex ? index : -1;
      // Определяем активна ли кнопка Сохранить.
      _isSubmitEnabled = _selectedIndex != -1;
    });
  }

  // возвращаем выбранную категорию
  void _onSubmit() => Navigator.of(context).pop(_types[_selectedIndex]);

  void _onBack() => Navigator.of(context).pop();
}
