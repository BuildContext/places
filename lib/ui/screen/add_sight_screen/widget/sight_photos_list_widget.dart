import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_widget.dart';
import 'package:places/ui/screen/add_sight_screen/widget/sight_photo_widget.dart';

/// Список фотографий места
///
/// [sightPhotos] список [SightPhoto], который надо отобразить
/// Список скролится горизонтально, первым элементом выводится кнопка Добавить.
/// [onTap] срабатываем при тапе на фото, в параметрах index
/// [onDelete] при тапе на крестик,  в параметрах index
/// [onAdd] при тапе на кнопку добавления фото, первый элемент
/// высоту виджета определяет параметр [height], по-умолчанию 90.0
class SightPhotosListWidget extends StatelessWidget {
  final List<SightPhoto> sightPhotos;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;
  final ValueChanged<int> onDelete;
  final double height;

  const SightPhotosListWidget({
    Key key,
    @required this.sightPhotos,
    @required this.onTap,
    @required this.onDelete,
    @required this.onAdd,
    this.height = 90.0,
  })  : assert(sightPhotos != null),
        assert(onTap != null),
        assert(onDelete != null),
        assert(onAdd != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // прибавляем 1, чтобы первым элементов добавить кнопку AddPhotoWidget
        // см. _buildItem
        itemCount: sightPhotos.length + 1,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return AddPhotoWidget(
        key: const ValueKey('AddPhotoWidget'),
        onTap: onAdd,
      );
    }

    final photoIndex = index - 1;
    return SightPhotoWidget(
      key: ObjectKey(sightPhotos[photoIndex]),
      photo: sightPhotos[photoIndex],
      onTap: () => onTap(photoIndex),
      onDelete: () => onDelete(photoIndex),
    );
  }
}
