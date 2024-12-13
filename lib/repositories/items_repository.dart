import 'package:dartz/dartz.dart';
import 'package:falcons_task/errors/failures.dart';
import 'package:falcons_task/models/merged_data.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<MergedData>>> getMergedData({bool isRefresh = false});
}
