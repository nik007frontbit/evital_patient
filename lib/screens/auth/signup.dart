import 'package:evital_patient/cubit/signup/sign_up_cubit.dart';
import 'package:evital_patient/screens/dashboard/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../cubit/password/password_cubit.dart';
import '../../cubit/password/password_state.dart';
import '../../utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstController = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _referralController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 9),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "To access your orders, offers & more!",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    commonTextField(
                      _firstController,
                      "First Name",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    commonTextField(
                      _secondController,
                      "Second Name",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    commonTextField(
                      _mobileController,
                      "Mobile",
                      isMobile: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    commonTextField(
                      _referralController,
                      "Referral Code (Optional)",
                      isOptional: true,
                    ),
                    BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpContinue) {
                          print("object");
                          return Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "You will receive OTP shortly",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.blue),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Pinput(
                                    controller: _otpController,
                                    defaultPinTheme: PinTheme(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: AppColors.grey,
                                              width: 2,
                                            ))),
                                    errorPinTheme: PinTheme(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: AppColors.red,
                                              width: 2,
                                            ))),
                                    focusedPinTheme: PinTheme(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: AppColors.blue,
                                              width: 2,
                                            ))),
                                    onCompleted: (pin) => print(pin),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Otp is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const Text(
                                    "Resend",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.blueLight,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              commonTextField(
                                _pinController,
                                "Pincode",
                                isMobile: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              commonPasswordField(
                                _passController,
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is SignUpError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        }

                        if (state is SignUpSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                          ),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.blue,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (state is SignUpContinue) {
                                BlocProvider.of<SignUpCubit>(context)
                                    .onSignUpSubmit(
                                  firstName: _firstController.text,
                                  lastName: _secondController.text,
                                  phone: _mobileController.text,
                                  referral: _referralController.text,
                                  password: _passController.text,
                                  otp: _otpController.text,
                                  pinCode: _pinController.text,
                                );
                              } else {
                                BlocProvider.of<SignUpCubit>(context).onOtpSend(
                                  firstName: _firstController.text,
                                  lastName: _secondController.text,
                                  phone: _mobileController.text,
                                  referral: _referralController.text,
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Back to Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  commonTextField(
    TextEditingController controller,
    String name, {
    bool isOptional = false,
    bool isMobile = false,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      keyboardType: isMobile ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(
          color: AppColors.blue,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.blue,
        )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty && isOptional == false) {
          return '$name is Required';
        } else if (isMobile == true && !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Mobile number can only contain digits';
        }
        return null;
      },
    );
  }

  commonPasswordField(
    TextEditingController controller,
  ) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: BlocBuilder<PasswordCubit, PasswordState>(
        builder: (context, state) {
          return TextFormField(
            controller: controller,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(
                color: AppColors.blue,
              ),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.blue,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<PasswordCubit>(context).toggleShow();
                },
                icon: Icon(
                  state.showPass
                      ? Icons.remove_red_eye
                      : CupertinoIcons.eye_slash_fill,
                ),
              ),
            ),
            obscureText: state.showPass,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
