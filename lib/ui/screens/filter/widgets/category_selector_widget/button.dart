part of 'category_selector_widget.dart';

/// Кнопка фильтра категорий используется в родительском [FilterCategoriesWidget]
class FilterCategoryButton extends StatelessWidget {
  final bool isActive;
  final SightCategory model;
  final VoidCallback onTap;
  const FilterCategoryButton({
    Key? key,
    required this.isActive,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(model.data.iconPath),
              ),
              if (isActive)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(AppAssets.filterChoiceIcon),
                )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(model.data.title),
      ],
    );
  }
}
