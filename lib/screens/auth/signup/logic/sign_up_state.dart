part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpContinue extends SignUpState {}
final class SignUpOtpSend extends SignUpState {}
final class SignUpSuccess extends SignUpState {}

final class SignUpError extends SignUpState {
  String error;

  SignUpError({required this.error});
}
