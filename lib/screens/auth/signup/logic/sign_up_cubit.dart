import 'package:bloc/bloc.dart';
import 'package:evital_patient/screens/auth/signup/logic/sign_up_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  SignUpRepo signUpRepo = SignUpRepo();

  onOtpSend({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    var result = await signUpRepo.sendOpt(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      referral: referral,
    );
    // Handle the result
    if (result['success']) {
      // Show OTP dialog on success
      emit(SignUpContinue());
    } else {
      emit(SignUpError(error: result['message']));
    }
  }

  onSignUpSubmit({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
    required String password,
    required String otp,
    required String pinCode,
  }) async {
    var result = await signUpRepo.sendSignDetails(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      referral: referral,
      password: password,
      otp: otp,
      pinCode: pinCode,
    );
    // Handle the result
    if (result['success']) {
      // Show OTP dialog on success
      emit(SignUpSuccess());
    } else {
      emit(SignUpError(error: result['message']));
    }
  }
}
