import 'package:bloc/bloc.dart';
import 'package:evital_patient/cubit/password/password_state.dart';

// Password Cubit
class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordState(showPass: true));

  void toggleShow() {
    emit(PasswordState(showPass: !state.showPass));
  }
}
