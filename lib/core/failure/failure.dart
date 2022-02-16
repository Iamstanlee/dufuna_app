abstract class Failure {
  String get msg;
}

class NetworkFailure extends Failure {
  @override
  String get msg => "Network unavailable";
}

class ServerFailure extends Failure {
  final String _msg;
  ServerFailure([this._msg = '']);
  @override
  String get msg => _msg;
}

class InputValidationFailure extends Failure {
  final String _msg;
  InputValidationFailure([this._msg = 'Some fields are invalid']);
  @override
  String get msg => _msg;
}
