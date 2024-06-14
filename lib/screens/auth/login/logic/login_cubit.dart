import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'login_repo.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginRepo loginRepo = LoginRepo();

  onSubmit({
    required String phone,
    required String password,
  }) async {
    var result =
        await loginRepo.sendLoginDetails(phone: phone, password: password);
    // Handle the result
    if (result['success']) {
      // Show OTP dialog on success
      emit(LoginSuccess());
    } else {
      emit(LoginError(error: result['message']));
    }
  }
}
