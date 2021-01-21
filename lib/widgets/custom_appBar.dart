import 'package:flutter/material.dart';
import 'package:places/constants/colours_const.dart';
import 'package:places/constants/text_styles.dart';

/// Custom appbar with PreferredSizeWidget

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final String title;
  final double height;

  const CustomAppBar({
    Key key,
    this.title,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: 280,
                  maxHeight: 100
              ),
              child: Text(title, style: largeTitleTextStyle(color: secondary),),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
