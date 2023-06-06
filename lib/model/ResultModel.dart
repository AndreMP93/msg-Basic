class ResultModel<T> {
  final _type;
  final T? data;
  final String message;

  ResultModel.success(this.data)
      : _type = _ResultType.Success,
        message = "";

  ResultModel.error(this.message)
      : _type = _ResultType.Error,
        data = null;

  ResultModel.loading()
      : _type = _ResultType.Loading,
        data = null,
        message = "";

  bool get isSuccess => _type == _ResultType.Success;
  bool get isError => _type == _ResultType.Error;
  bool get isLoading => _type == _ResultType.Loading;

  @override
  String toString() {
    switch (_type) {
      case _ResultType.Success:
        return 'Success[data=$data]';
      case _ResultType.Error:
        return 'Error[message=$message]';
      case _ResultType.Loading:
        return 'Loading';
      default:
        return '';
    }
  }
}

class _ResultType {
  static const Success = 0;
  static const Error = 1;
  static const Loading = 2;
}

class Success<T> {
  final T data;

  Success(this.data);

  @override
  String toString() => 'Success[data=$data]';
}

class Error {
  final String? message;

  Error(this.message);

  @override
  String toString() => 'Error[message=$message';
}

class Loading {
  @override
  String toString() => 'Loading';
}
