import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Элемент списка результата поиска
class SearchResultItem extends StatelessWidget {
  final Sight sight;
  final VoidCallback onTap;

  const SearchResultItem({
    Key key,
    @required this.sight,
    @required this.onTap,
  })  : assert(sight != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 56.0,
          width: 56.0,
          child: NetworkImageWithSpinner(
            url: sight.url,
          ),
        ),
      ),
      title: Text(sight.name),
      subtitle: Text(sight.type.name),
      onTap: onTap,
    );
  }
}
