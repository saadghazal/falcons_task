import 'package:dartz/dartz.dart';
import 'package:falcons_task/errors/failures.dart';
import 'package:falcons_task/models/merged_data.dart';
import 'package:falcons_task/repositories/items_repository.dart';

class RefreshDataUseCase {
  final ItemsRepository itemsRepository;

  const RefreshDataUseCase({
    required this.itemsRepository,
  });

  Future<Either<Failure, List<MergedData>>> call() async {
    return itemsRepository.getMergedData(isRefresh: true);
  }
}
