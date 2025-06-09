abstract class AppStatus {
  const AppStatus();
}

class InitialStatus extends AppStatus {
  const InitialStatus();
}

class IsLoading extends AppStatus {}

class IsSuccess extends AppStatus {
  const IsSuccess();
}

class IsFailed extends AppStatus {
  final Object? exception;
  final String? message;

  IsFailed({this.exception, this.message});
}
