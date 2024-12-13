import 'package:dartz/dartz.dart';
import 'package:falcons_task/errors/failures.dart';
import 'package:falcons_task/models/merged_data.dart';
import 'package:falcons_task/repositories/items_repository.dart';

class GetItemsUseCase {
  final ItemsRepository itemsRepository;

  const GetItemsUseCase({
    required this.itemsRepository,
  });

  Future<Either<Failure, List<MergedData>>> call() async {
    return await itemsRepository.getMergedData();
  }
}
