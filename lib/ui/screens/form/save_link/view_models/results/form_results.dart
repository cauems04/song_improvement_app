sealed class FormResult {
  final String message;

  const FormResult(this.message);
}

class SuccessResult extends FormResult {
  const SuccessResult(super.piriri);
}

class AlertResult extends FormResult {
  const AlertResult(super.message);
}

class ErrorResult extends FormResult {
  const ErrorResult(super.message);
}
