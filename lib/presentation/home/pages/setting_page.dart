import 'package:altius_absensi_app/core/core.dart';
import 'package:altius_absensi_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:altius_absensi_app/presentation/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              success: () {
                context.pushReplacement(const LoginPage());
              },
              failed: (message) =>
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                backgroundColor: AppColors.red,
              )),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () => Button.filled(
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      },
                      label: 'Logout',
                    ),
                loading: () => const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
