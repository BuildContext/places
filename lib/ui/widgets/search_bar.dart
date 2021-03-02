import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/text_field_with_clear.dart';

/// Поле ввода для поиска места
///
/// имеет 2 состояния определяемое поем [readOnly]
/// [readOnly] = true: поле ввода не редактируемое и справа кнопка Фильтр,
/// с каллбеком [onFilterTap]. На само поле ввода есть каллбек [onTap]
/// [readOnly] = false: в поле ввода можно вводить текст. При каждом вводе
/// срабатывает [onChanged], при submit [onSubmitted]
/// Если введен текст, то справа появляется кнопка очистки поля. Поле очищается
/// и срабатывает [onClear]
class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final VoidCallback onFilterTap;
  final VoidCallback onClear;
  final TextEditingController controller;
  final String text;
  final bool readOnly;

  const SearchBar({
    Key key,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.text,
    this.onFilterTap,
    this.onChanged,
    this.onClear,
    this.controller,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // тут кнопка фильтра реализована через Stack, чтобы не происходил
      // onTap у поля ввода, в случае если ее реализовывать через suffix поля
      // ввода.  https://github.com/flutter/flutter/issues/39376
      child: Stack(
        children: [
          Theme(
            data: Theme.of(context)
                .copyWith(inputDecorationTheme: _searchInputDecorationTheme),
            child: TextFieldWithClear(
              controller: controller,
              autoFocus: !readOnly,
              text: text,
              hintText: AppStrings.searchBarHint,
              readOnly: readOnly,
              prefixIcon: SvgIcon(
                icon: SvgIcons.search,
                color: Theme.of(context).disabledColor,
              ),
              onChanged: (value) => onChanged?.call(value),
              onSubmitted: (value) => onSubmitted?.call(value),
              onTap: () => onTap?.call(),
              onClear: () => onClear?.call(),
            ),
          ),
          if (readOnly)
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () => onFilterTap?.call(),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgIcon(
                    icon: SvgIcons.filter,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

final _searchInputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 16.0,
  ),
  filled: true,
  fillColor: AppColors.searchBarBgr,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(
      color: AppColors.searchBarBgr,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(
      color: AppColors.searchBarBgr,
    ),
  ),
);
