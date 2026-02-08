sealed class SaveResult {
  final String message;

  const SaveResult(this.message);
}

class SuccessResult extends SaveResult {
  final int recordId;

  const SuccessResult(super.message, this.recordId);
}

class ErrorResult extends SaveResult {
  const ErrorResult(super.message);
}
