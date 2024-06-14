import 'package:evital_patient/screens/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/splash_cubit.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SplashProcess) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginScreen(),
                  ),
                  (route) => false);
            }
          },
          child: Center(child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width/3),
            child: Image.asset("assets/image/logo.png"),
          )),
        ),
      ),
    );
  }
}
