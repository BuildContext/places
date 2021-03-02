import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:places/config.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/favorites_interactor.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/store/sight_list_store/sight_list_store.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/screen/sight_list_screen/widget/add_button.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:provider/provider.dart';

/// Экран со списком интересных мест
class SightListScreen extends StatefulWidget {
  static const String routeName = 'SightListScreen';

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  SightListStore _store;
  FavoritesInteractor favoritesInteractor;

  // Фильтр, который применяется к списку мест на этом экране
  Filter _filter = Filter(
    minDistance: Config.minRange,
    maxDistance: Config.maxRange,
    types: [],
  );

  @override
  void initState() {
    super.initState();
    _store = SightListStore(
      sightRepository: context.read<SightRepository>(),
      locationRepository: context.read<LocationRepository>(),
    );
    _store.requestFilteredSights(filter: _filter);

    favoritesInteractor = context.read<FavoritesInteractor>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(index: 0),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddButton(onPressed: _onAddPressed),
      body: Observer(
        builder: (context) {
          // в случае загрузки показываем крутилку
          if (_store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // В случае ошибки показываем сообщение
          if (_store.hasError) {
            return CenterMessage(
              icon: SvgIcons.error,
              title: AppStrings.sightSearchErrorTitle,
              subtitle:
                  '${AppStrings.sightSearchErrorSubtitle}\n\n${_store.sightListFuture.error}',
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchSliverPersistentHeaderDelegate(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  child: SearchBar(
                    readOnly: true,
                    onTap: _onSearchTap,
                    onFilterTap: _onFilterTap,
                  ),
                ),
              ),
              _buildSightListWidget(_store.sightListFuture.value),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSightListWidget(List<Sight> sights) {
    final List<Widget> sightCardsList = [];
    for (final sight in sights) {
      sightCardsList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SightCard(
          sight: sight,
          onTap: () => _onCardTap(sight),
          actionsBuilder: (_) {
            return [
              // favorite btn
              StreamBuilder<bool>(
                stream: favoritesInteractor.favoriteStream(sight),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  final bool isFav = snapshot.data;
                  return SightCardActionButton(
                    onTap: () {
                      favoritesInteractor.switchFavorite(sight);
                    },
                    icon: isFav ? SvgIcons.heartFill : SvgIcons.heart,
                  );
                },
              ),
            ];
          },
        ),
      ));
    }

    return MediaQuery.of(context).orientation == Orientation.portrait
        ? SliverList(
            delegate: SliverChildListDelegate(sightCardsList),
          )
        : SliverGrid(
            delegate: SliverChildListDelegate(sightCardsList),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
            ),
          );
  }

  Future<void> _onAddPressed() async {
    await Navigator.of(context).pushNamed(
      AddSightScreen.routeName,
    );
  }

  void _onSearchTap() {
    Navigator.of(context).pushNamed(
      SightSearchScreen.routeName,
      arguments: _filter,
    );
  }

  Future<void> _onFilterTap() async {
    final newFilter = await Navigator.of(context).pushNamed(
      FiltersScreen.routeName,
      arguments: _filter,
    ) as Filter;

    if (newFilter != null) {
      // Обновляем в соответствии с новым фильтром
      _filter = newFilter;
      _store.requestFilteredSights(filter: _filter);
    }
  }

  void _onCardTap(Sight sight) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
  }
}

/// Заголовок страницы.  Меняет размер шрифта в соответствии с высотой.
/// Слова переносятся автоматически.
class SearchSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final textSizeTween = Tween<double>(begin: 32, end: 18).chain(
      CurveTween(curve: Curves.easeOutCubic),
    );
    final progress = shrinkOffset / maxExtent;
    final fontSize = textSizeTween.transform(progress);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            // ограничиваем ширину в 300,
            // чтобы перенос слов при скролле был более адекватен
            width: 300,
            child: Text(
              AppStrings.sightListAppBar,
              style: AppTextStyles.appBarTitle.copyWith(
                fontSize: fontSize,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
