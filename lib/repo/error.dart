class NHSError {
  int _errorCode;
  String _message;

  NHSError(this._errorCode, this._message);

  String get message => _message;

  int get errorCode => _errorCode;

  @override
  String toString() {
    print("[$errorCode]  $message");
    return _message;
  }
}

class ErrorCodes {
  static const int NO_INTERNET = 101;
  static const int SERVER_ERROR = 102;
}
