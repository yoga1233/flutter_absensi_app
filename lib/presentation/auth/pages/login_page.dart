import 'package:altius_absensi_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:altius_absensi_app/presentation/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpaceHeight(50),
              Image.asset(
                Assets.images.logo.path,
                width: MediaQuery.of(context).size.width,
                height: 100,
              ),
              const SpaceHeight(107),
              CustomTextField(
                controller: emailController,
                label: 'Email Address',
                showLabel: false,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Assets.icons.email.path,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SpaceHeight(20),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                showLabel: false,
                obscureText: !isShowPassword,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Assets.icons.password.path,
                    height: 20,
                    width: 20,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isShowPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                ),
              ),
              const SpaceHeight(104),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (data) {
                      context.pushReplacement(const MainPage());
                    },
                    failed: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColors.red,
                        content: Text(
                          message,
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ));
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          // context.pushReplacement(const MainPage());
                          context.read<LoginBloc>().add(
                                LoginEvent.login(emailController.text,
                                    passwordController.text),
                              );
                        },
                        label: 'Sign In',
                      );
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                    failed: (message) {
                      return Button.filled(
                        onPressed: () {
                          // context.pushReplacement(const MainPage());
                          context.read<LoginBloc>().add(
                                LoginEvent.login(emailController.text,
                                    passwordController.text),
                              );
                        },
                        label: 'Sign In',
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
