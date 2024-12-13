abstract class Failure {
  late String errorMessage;
}

class FetchFailure extends Failure {
  @override
  final String errorMessage;

  FetchFailure({
    required this.errorMessage,
  });
}
