import 'package:dartz/dartz.dart';
import 'package:falcons_task/data_sources/local_storage_data_source.dart';
import 'package:falcons_task/data_sources/remote_data_source.dart';
import 'package:falcons_task/errors/exceptions.dart';
import 'package:falcons_task/errors/failures.dart';
import 'package:falcons_task/models/merged_data.dart';
import 'package:falcons_task/repositories/items_repository.dart';
import 'package:falcons_task/services/local_storage_service.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalStorageService localStorageService;
  final LocalStorageDataSource localStorageDataSource;

  const ItemsRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorageDataSource,
    required this.localStorageService,
  });

  @override
  Future<Either<Failure, List<MergedData>>> getMergedData({bool isRefresh = false}) async {
    try {
      var data;
      if (await localStorageService.isDBExist()) {
        if (isRefresh) {
          data = await remoteDataSource.fetchData();
        } else {
          data = await localStorageDataSource.fetchData();
        }
      } else {
        data = await remoteDataSource.fetchData();
      }
      return Right(data);
    } on FetchException catch (e) {
      return Left(FetchFailure(errorMessage: e.message));
    }
  }
}
