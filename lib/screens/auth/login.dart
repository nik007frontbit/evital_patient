import 'package:evital_patient/cubit/login/login_cubit.dart';
import 'package:evital_patient/cubit/password/password_cubit.dart';
import 'package:evital_patient/screens/auth/signup.dart';
import 'package:evital_patient/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/password/password_state.dart';
import '../dashboard/home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
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
                      "Login",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "To access your orders, offers & more!",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    commonTextField(_phoneController, "Mobile", isMobile: true),
                    const SizedBox(
                      height: 15,
                    ),
                    commonPasswordField(_passwordController),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        }

                        if (state is LoginSuccess) {
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
                            vertical: 15,
                          ),
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppColors.blue,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).onSubmit(
                                phone: _phoneController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 9,
                        color: AppColors.black.withOpacity(0.2),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: AppColors.black),
                      ),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.blue,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Sign up Now",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
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
