part of 'category_selector_widget.dart';

///Виджет фильтра мест по категориям (парк, кафе, отель ...) мест
class FilterCategoriesWidget extends StatelessWidget {
  /// Все категории
  final List<SightCategory> allCategories;

  /// Активные категории
  final Set<SightCategory> selectedCategories;

  /// Тап по категории (коллбек виджету-родителю)
  final void Function(SightCategory) onTapCategory;

  const FilterCategoriesWidget({
    super.key,
    required this.allCategories,
    required this.selectedCategories,
    required this.onTapCategory,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: allCategories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => FilterCategoryButton(
        isActive: selectedCategories.contains(allCategories[index]),
        onTap: () {
          onTapCategory(allCategories[index]);
        },
        model: allCategories[index],
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
    );
  }
}
