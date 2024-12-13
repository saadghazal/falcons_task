import 'package:falcons_task/models/merged_data.dart';
import 'package:falcons_task/usecases/get_items_usecase.dart';
import 'package:falcons_task/usecases/refresh_data_usecase.dart';
import 'package:get/get.dart';

enum FetchStatus { initial, loading, success, error }

enum SelectedFilter { all, descending, ascending }

class ItemsController extends GetxController {
  final GetItemsUseCase getItemsUseCase;
  final RefreshDataUseCase refreshDataUseCase;
  ItemsController({
    required this.getItemsUseCase,
    required this.refreshDataUseCase,
  });
  FetchStatus _state = FetchStatus.initial;
  FetchStatus get state => _state;
  SelectedFilter _filter = SelectedFilter.all;
  SelectedFilter get filter => _filter;
  List<MergedData> _originalItems = [];

  List<MergedData> _showedItems = [];
  List<MergedData> get showedItems => _showedItems;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    _state = FetchStatus.loading;
    update();
    var result = await getItemsUseCase();
    result.fold((failure) {
      _state = FetchStatus.error;
      _errorMessage = failure.errorMessage;
      update();
    }, (data) {
      _state = FetchStatus.success;
      _originalItems.addAll(data);
      _showedItems.addAll(data);
      update();
    });
  }

  Future<void> refreshData() async {
    _state = FetchStatus.loading;
    update();
    var result = await refreshDataUseCase();
    result.fold((failure) {
      _state = FetchStatus.error;
      _errorMessage = failure.errorMessage;
      update();
    }, (data) {
      _state = FetchStatus.success;
      _originalItems.addAll(data);
      _showedItems.addAll(data);
      update();
    });
  }

  void search(String itemName) {
    _showedItems = _originalItems.where((item) => item.itemName.contains(itemName)).toList();
    update();
  }

  void clearFilter() {
    _showedItems = [];
    _showedItems.addAll(_originalItems);
    _filter = SelectedFilter.all;
    update();
  }

  void filterAscending() {
    showedItems.sort((a, b) => a.quantity.compareTo(b.quantity),);
    _filter = SelectedFilter.ascending;
    update();
  }
  void filterDescending() {
    showedItems.sort((a, b) => b.quantity.compareTo(a.quantity),);
    _filter = SelectedFilter.descending;
    update();
  }
}
