
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}
