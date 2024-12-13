import 'package:dartz/dartz.dart';
import 'package:falcons_task/errors/failures.dart';
import 'package:falcons_task/models/merged_data.dart';
import 'package:falcons_task/services/local_storage_service.dart';

class LocalStorageDataSource {
  final LocalStorageService localStorageService;
  const LocalStorageDataSource({
    required this.localStorageService,
  });
  Future<List<MergedData>> fetchData() async {
    var rawData = await localStorageService.getStoredData();
    List<MergedData> mergedData = mergedDataFromJSON(rawData);
    print("Local ${mergedData.length}");
    return mergedData;
  }
}
