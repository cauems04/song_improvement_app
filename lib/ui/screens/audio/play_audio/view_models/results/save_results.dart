sealed class SaveResult {
  final String message;

  const SaveResult(this.message);
}

class SuccessResult extends SaveResult {
  const SuccessResult(super.message);
}

class ErrorResult extends SaveResult {
  const ErrorResult(super.message);
}
