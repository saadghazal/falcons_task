import 'package:falcons_task/controllers/items_controller.dart';
import 'package:falcons_task/data_sources/local_storage_data_source.dart';
import 'package:falcons_task/data_sources/remote_data_source.dart';
import 'package:falcons_task/repositories/items_repository.dart';
import 'package:falcons_task/repositories/items_repository_impl.dart';
import 'package:falcons_task/services/local_storage_service.dart';
import 'package:falcons_task/usecases/get_items_usecase.dart';
import 'package:falcons_task/usecases/refresh_data_usecase.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LocalStorageService());
    Get.put(RemoteDataSource(localStorageService: Get.find()));
    Get.put(LocalStorageDataSource(localStorageService: Get.find()));
    Get.put<ItemsRepository>(ItemsRepositoryImpl(
        remoteDataSource: Get.find(),
        localStorageService: Get.find(),
        localStorageDataSource: Get.find()));
    Get.put(GetItemsUseCase(itemsRepository: Get.find()));
    Get.put(RefreshDataUseCase(itemsRepository: Get.find()));

    Get.lazyPut(
      () => ItemsController(
        getItemsUseCase: Get.find(),
        refreshDataUseCase: Get.find(),
      ),
    );
  }
}
