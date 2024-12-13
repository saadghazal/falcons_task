class FetchException implements Exception {
  final String message;

  const FetchException({
    required this.message,
  });
}

class ItemsQuantityApiException extends FetchException {
  ItemsQuantityApiException({required super.message});
}

class ItemsApiException extends FetchException {
  ItemsApiException({required super.message});
}

class LocalStorageException extends FetchException {
  LocalStorageException({required super.message});
}
