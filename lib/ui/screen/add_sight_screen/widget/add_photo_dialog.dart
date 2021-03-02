import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

enum _AddPhotoDialogResult { cancel, camera, photo, file }

/// Диалог добавления фотографии с разных источников. camera, photo, file
class AddPhotoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddButtons(onSelect: (choice) => onSelect(context, choice)),
            const SizedBox(height: 16.0),
            _CancelButton(
              onSelect: () => onSelect(context, _AddPhotoDialogResult.cancel),
            )
          ],
        ),
      ),
    );
  }

  /// При выборе возвращает на предыдущий экран [SightPhoto] из выбранного провайдера
  /// Если нажали "отмена" или диалог закрыли, то ничего не возвращает (null)
  void onSelect(BuildContext context, _AddPhotoDialogResult choice) {
    switch (choice) {
      case _AddPhotoDialogResult.camera:
      case _AddPhotoDialogResult.photo:
      case _AddPhotoDialogResult.file:
        Navigator.of(context).pop(sightPhotosMocks[currentMockIndex]);
        // обновляем индекс мока, чтобы в след раз была другая фото
        if (currentMockIndex < sightPhotosMocks.length) {
          currentMockIndex++;
        }
        break;
      case _AddPhotoDialogResult.cancel:
        Navigator.of(context).pop();
        break;
    }
  }
}

// Группа кнопок выбора источника.
class _AddButtons extends StatelessWidget {
  final ValueChanged<_AddPhotoDialogResult> onSelect;

  const _AddButtons({
    Key key,
    @required this.onSelect,
  })  : assert(onSelect != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddButton(
              icon: SvgIcons.camera,
              text: AppStrings.addPhotoCamera,
              onPressed: () {
                onSelect(_AddPhotoDialogResult.camera);
              },
            ),
            const Divider(),
            _AddButton(
              icon: SvgIcons.photo,
              text: AppStrings.addPhotoPhoto,
              onPressed: () {
                onSelect(_AddPhotoDialogResult.photo);
              },
            ),
            const Divider(),
            _AddButton(
              icon: SvgIcons.file,
              text: AppStrings.addPhotoFile,
              onPressed: () {
                onSelect(_AddPhotoDialogResult.file);
              },
            )
          ],
        ),
      ),
    );
  }
}

// Кнопка выбора источника фото
class _AddButton extends StatelessWidget {
  final SvgData icon;
  final String text;
  final VoidCallback onPressed;

  const _AddButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  })  : assert(icon != null),
        assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            SvgIcon(icon: icon, color: AppColors.lightGray),
            const SizedBox(width: 12),
            Text(
              text,
              style: AppTextStyles.addPhotoDialogButton
                  .copyWith(color: AppColors.lightGray),
            ),
          ],
        ),
      ),
    );
  }
}

// Кнопка отмены
class _CancelButton extends StatelessWidget {
  final VoidCallback onSelect;

  const _CancelButton({
    Key key,
    @required this.onSelect,
  })  : assert(onSelect != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onSelect,
        child: Ink(
          height: 48.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).backgroundColor,
          ),
          child: Center(
            child: Text(
              AppStrings.addPhotoCancel.toUpperCase(),
              style: AppTextStyles.addPhotoDialogButton
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
