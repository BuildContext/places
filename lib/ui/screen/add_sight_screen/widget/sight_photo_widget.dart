import 'package:flutter/material.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Виджет - элемент списка фотографий для [SightPhotosListWidget],
/// с кнопкой удаления
///
/// [onTap] - при тапе на фото
/// [onDelete] - при тапе на кнопку "удалить"
class SightPhotoWidget extends StatelessWidget {
  final SightPhoto photo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SightPhotoWidget({
    Key key,
    @required this.photo,
    @required this.onTap,
    @required this.onDelete,
  })  : assert(photo != null),
        assert(onTap != null),
        assert(onDelete != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.up,
      onDismissed: (_) => onDelete(),
      child: GestureDetector(
        onTap: onTap,
        // LayoutBuilder тут, чтобы получить высоту сверху
        // и использовать для того, чтобы сделать виджет квадратным
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: NetworkImageWithSpinner(
                          url: photo.url,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: onDelete,
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: SvgIcon(
                                icon: SvgIcons.clear,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
