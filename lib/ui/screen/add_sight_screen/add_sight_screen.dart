import 'package:flutter/material.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_dialog.dart';
import 'package:places/ui/screen/add_sight_screen/widget/category_selector.dart';
import 'package:places/ui/screen/add_sight_screen/widget/sight_photos_list_widget.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/label.dart';
import 'package:places/ui/widgets/text_field_with_clear.dart';
import 'package:provider/provider.dart';

/// Экран добавления нового места
class AddSightScreen extends StatefulWidget {
  static const String routeName = 'AddSightScreen';

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _latFocusNode = FocusNode();
  final FocusNode _lonFocusNode = FocusNode();
  final FocusNode _descrFocusNode = FocusNode();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();

  SightInteractor sightInteractor;

  // Выбранная категория
  SightType _selectedSightType;

  // фотографии места
  final List<SightPhoto> _sightPhotos = [];

  // Доступность кнопки submit
  bool _isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();
    sightInteractor = context.read<SightInteractor>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addSightAppbarTitle),
        leading: TextButton(
          onPressed: _onBack,
          child: const Text(AppStrings.addSightAppbarCancel),
        ),
        leadingWidth: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Отступ  снизу, чтобы скролл под кнопку не забирался.
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              // SingleChildScrollView - чтобы при появлении клавиатуры не было overflow
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SightPhotosListWidget(
                      sightPhotos: _sightPhotos,
                      onTap: _onPhotoTap,
                      onAdd: _onAddPhotoTap,
                      onDelete: _onPhotoDeleteTap,
                    ),
                    const Label(
                      text: AppStrings.addSightCategory,
                      padding: EdgeInsets.all(0),
                    ),
                    CategorySelector(
                      value: _selectedSightType,
                      onTap: _onSelectCategory,
                    ),
                    const Divider(),
                    const SizedBox(height: 24.0),
                    const Label(text: AppStrings.addSightFormTitle),
                    TextFieldWithClear(
                      hintText: AppStrings.addSightHintTitle,
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      onSubmitted: (_) => _onSubmitTextField(_titleFocusNode),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Label(
                                  text: AppStrings.addSightFormLatitude),
                              TextFieldWithClear(
                                hintText: AppStrings.addSightHintLatitude,
                                focusNode: _latFocusNode,
                                onSubmitted: (_) =>
                                    _onSubmitTextField(_latFocusNode),
                                controller: _latController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Label(
                                  text: AppStrings.addSightFormLongitude),
                              TextFieldWithClear(
                                hintText: AppStrings.addSightHintLongitude,
                                focusNode: _lonFocusNode,
                                onSubmitted: (_) =>
                                    _onSubmitTextField(_lonFocusNode),
                                controller: _lonController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).accentColor),
                      child: const Text(AppStrings.addSightGetFromMap),
                    ),
                    const SizedBox(height: 24.0),
                    const Label(text: AppStrings.addSightFormDescription),
                    TextFieldWithClear(
                      hintText: AppStrings.addSightHintDescription,
                      maxLines: 3,
                      focusNode: _descrFocusNode,
                      onSubmitted: (_) => _onSubmitTextField(_descrFocusNode),
                      controller: _descrController,
                      textInputAction: TextInputAction.go,
                    ),
                  ],
                ),
              ),
            ),

            // Кнопка "Создать" всегда прижата к низу.
            Align(
              alignment: Alignment.bottomCenter,
              child: IconElevatedButton(
                text: AppStrings.addSightBtnCreate,
                onPressed: _isSubmitEnabled ? _onSubmit : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _latController.dispose();
    _lonController.dispose();
    _descrController.dispose();
    super.dispose();
  }

  // попадаем сюда после submit на любом textField,
  // focusNode показывает откуда пришли
  // переключаем фокус на следующее поле и обновляем кнопку
  void _onSubmitTextField(FocusNode focusNode) {
    // Логика перемещения фокуса
    if (focusNode == _titleFocusNode) {
      _latFocusNode.requestFocus();
    } else if (focusNode == _latFocusNode) {
      _lonFocusNode.requestFocus();
    } else if (focusNode == _lonFocusNode) {
      _descrFocusNode.requestFocus();
    }

    // обновляем доступность кнопки submit, если все поля заполнены
    setState(() {
      _isSubmitEnabled = _selectedSightType != null &&
          _titleController.text != '' &&
          _latController.text != '' &&
          _lonController.text != '' &&
          _descrController.text != '';
    });
  }

  // Выбор категории
  Future<void> _onSelectCategory() async {
    final result = await Navigator.of(context).pushNamed(
      SelectCategoryScreen.routeName,
    ) as SightType;

    setState(() {
      _selectedSightType = result;
    });

    // если выбрана категория, то фокус на первом поле.
    if (_selectedSightType != null) {
      _titleFocusNode.requestFocus();
    }
  }

  // нажатие на submit, добавляем новое место в базу
  void _onSubmit() {
    final Sight newSight = Sight(
      name: _titleController.text,
      point: GeoPoint(
        lon: double.parse(_lonController.text),
        lat: double.parse(_latController.text),
      ),
      details: _descrController.text,
      url: 'https://republica-dominikana.ru/wp-content/uploads/2018/08/51.jpg',
      type: _selectedSightType,
    );

    sightInteractor.addNewSight(newSight);
  }

  // Добавление фото
  Future<void> _onAddPhotoTap() async {
    final SightPhoto sightPhoto = await showDialog(
        context: context,
        builder: (_) {
          return AddPhotoDialog();
        });

    if (sightPhoto != null) {
      setState(() {
        _sightPhotos.insert(0, sightPhoto);
      });
    }
  }

  // Тап на карточке с фото
  void _onPhotoTap(int index) {}

  // Удалить фото
  void _onPhotoDeleteTap(int index) {
    setState(() {
      _sightPhotos.removeAt(index);
    });
  }

  void _onBack() {
    Navigator.of(context).pop();
  }
}
