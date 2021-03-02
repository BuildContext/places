import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favorites_list_bloc/favorites_list_bloc.dart';
import 'package:places/blocs/visited_list_bloc/visited_list_bloc.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_bottomsheet.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar.dart';
import 'package:places/ui/widgets/custom_tab_bar/custom_tab_bar_item.dart';
import 'package:places/ui/widgets/draggable_dismissible_sight_card.dart';
import 'package:places/ui/widgets/ios_date_picker.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_widget.dart';

/// Экран Хочу посетить/Посещенные места
class VisitingScreen extends StatefulWidget {
  static const String routeName = 'VisitingScreen';

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  FavoritesListBloc _favoritesListBloc;
  VisitedListBloc _visitedListBloc;

  @override
  void initState() {
    super.initState();

    _favoritesListBloc = BlocProvider.of<FavoritesListBloc>(context);
    _visitedListBloc = BlocProvider.of<VisitedListBloc>(context);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
      // при смене таба инициируем обновление Favorites или Visited
      if (_tabController.index == 0) {
        _favoritesListBloc.add(const LoadFavoritesListEvent(isHidden: false));
      } else if (_tabController.index == 1) {
        _visitedListBloc.add(const LoadVisitedListEvent(isHidden: false));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.visitingAppBarTitle,
          style: AppTextStyles.appBarTitle.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
        bottom: CustomTabBar(
          controller: _tabController,
          onTabTap: (index) => _tabController.animateTo(index),
          items: [
            CustomTabBarItem(
              text: AppStrings.visitingWantToVisitTab,
              activeStyle:
                  AppTextStyles.visitingActiveTab.copyWith(color: Colors.white),
              style: AppTextStyles.visitingTab
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
            CustomTabBarItem(
              text: AppStrings.visitingVisitedTab,
              activeStyle:
                  AppTextStyles.visitingActiveTab.copyWith(color: Colors.white),
              style: AppTextStyles.visitingTab
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 2),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<FavoritesListBloc, FavoritesListState>(
            cubit: _favoritesListBloc,
            builder: (context, state) {
              if (state is LoadFavoritesListInProgressState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is LoadedFavoritesState) {
                return SightListWidget(
                  padding: const EdgeInsets.all(16.0),
                  children: _buildToVisitSightList(state.sights),
                );
              }

              // Если явно передана ошибка, то показываем сообщение из нее
              // или если неизвестный state, то просто показываем ошибку
              final errorMessage = state is ErrorFavoritesListState
                  ? state.message
                  : 'Unknown state';
              return _ErrorMessage(message: errorMessage);
            },
          ),
          BlocBuilder<VisitedListBloc, VisitedListState>(
            cubit: _visitedListBloc,
            builder: (context, state) {
              if (state is VisitedListLoadingInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is VisitedListLoaded) {
                return SightListWidget(
                  padding: const EdgeInsets.all(16.0),
                  children: _buildVisitedSightList(state.sights),
                );
              }

              final errorMessage = state is ErrorVisitedListState
                  ? state.message
                  : 'Unknown state';
              return _ErrorMessage(message: errorMessage);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Карточки "Хочу посетить"
  List<Widget> _buildToVisitSightList(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => _onSightTap(sights[i]),
          actionsBuilder: (_) => [
            // calendar btn
            SightCardActionButton(
              onTap: () => _onCalendarTap(sights[i]),
              icon: SvgIcons.calendar,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => _onDeleteFromFavorites(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) => _onSortFavorites(
            sight: droppedSight,
            target: sights[i],
          ),
          onDismissed: () => _onDeleteFromFavorites(sights[i]),
        ),
      );
    }
    return res;
  }

  // Карточки посещенные
  // На карточке другие action-кнопки, поэтому для простоты разделил на 2 метода
  // _buildToVisitSightList и _buildVisitedSightList
  List<Widget> _buildVisitedSightList(List<Sight> sights) {
    final List<Widget> res = [];
    for (var i = 0; i < sights.length; i++) {
      res.add(
        DraggableDismissibleSightCard(
          key: ValueKey(sights[i].id),
          sight: sights[i],
          onTap: () => _onSightTap(sights[i]),
          actionsBuilder: (_) => [
            // share btn
            SightCardActionButton(
              onTap: () {},
              icon: SvgIcons.share,
            ),
            // delete btn
            SightCardActionButton(
              onTap: () => _onDeleteFromVisited(sights[i]),
              icon: SvgIcons.delete,
            ),
          ],
          onSightDrop: (droppedSight) => _onSortVisited(
            sight: droppedSight,
            target: sights[i],
          ),
          onDismissed: () => _onDeleteFromVisited(sights[i]),
        ),
      );
    }
    return res;
  }

  // Удаляем место из Favorites
  void _onDeleteFromFavorites(Sight sight) {
    _favoritesListBloc.add(RemoveFromFavoritesListEvent(sight));
  }

  // todo добавить функцию хранения сортировки в FavoritesRepository
  // Сортируем место из Favorites. Наверх target помещается sight
  Future<void> _onSortFavorites({Sight sight, Sight target}) async {}

  // Удаляем место из Visited
  void _onDeleteFromVisited(Sight sight) {
    _visitedListBloc.add(RemoveFromVisitedListEvent(sight));
  }

  // todo добавить функцию хранения сортировки в VisitedRepository
  // Сортируем место из Visited. Наверх target помещается sight
  Future<void> _onSortVisited({Sight sight, Sight target}) async {}

  Future<void> _onSightTap(Sight sight) async {
    // На bottomSheet может быть нажато сердечко,
    // поэтому при возврате обновляем списки
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SightDetailsBottomSheet(sight: sight);
        });
    _favoritesListBloc.add(const LoadFavoritesListEvent());
    _visitedListBloc.add(const LoadVisitedListEvent());
  }

  Future<void> _onCalendarTap(Sight sight) async {
    final first = DateTime.now();
    // на 30 лет вперед
    final last = first.add(const Duration(days: 365 * 30));

    DateTime date;

    if (Platform.isAndroid) {
      date = await showDatePicker(
        context: context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    } else if (Platform.isIOS) {
      date = await showIosDatePicker(
        context: context,
        initialDate: first,
        firstDate: first,
        lastDate: last,
      );
    }

    if (date != null) {
      print('Выбрана дата посещения ${date.toString()}');
    }
  }
}

/// Виджет для показа сообщения об ошибке на экране VisitingScreen
class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({Key key, this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return CenterMessage(
      icon: SvgIcons.error,
      title: AppStrings.sightSearchErrorTitle,
      subtitle: '${AppStrings.sightSearchErrorSubtitle}\n\n$message',
    );
  }
}
