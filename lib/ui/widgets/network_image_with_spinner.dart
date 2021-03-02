import 'package:flutter/material.dart';

/// Виджет загружает и показывает изображение из сети по адресу [url].
///
/// Во время загрузки вместо изображения показывает спиннер.
class NetworkImageWithSpinner extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const NetworkImageWithSpinner({
    Key key,
    @required this.url,
    this.fit = BoxFit.cover,
  })  : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // загрузка завершена, показываем картинку
          return child;
        } else {
          // в документации expectedTotalBytes может быть null поэтому в этом кейсе показываем простую крутилку
          if (loadingProgress.expectedTotalBytes == null ||
              loadingProgress.expectedTotalBytes == 0) {
            return const CircularProgressIndicator();
          }

          // Вычисляем прогресс для спиннера
          final progress = loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes;
          return Center(
            child: CircularProgressIndicator(value: progress),
          );
        }
      },
    );
  }
}
