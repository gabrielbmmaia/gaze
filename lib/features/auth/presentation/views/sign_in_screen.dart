import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/app_background.dart';
import 'package:gaze/core/common/widgets/rounded_button.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/core/utils/core_utils.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/auth/presentation/views/sign_up_screen.dart';
import 'package:gaze/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:gaze/features/dashboard/presentation/views/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as UserEntity);
            Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
          }
        },
        builder: (context, state) {
          return AppBackground(
            backgroundColor: Colors.white,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              children: [
                const Align(
                  child: Text(
                    StringRes.appTitle,
                    style: TextStyle(
                      fontFamily: Fonts.satisfy,
                      fontWeight: FontWeight.w700,
                      fontSize: 90,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SignUpScreen.routeName,
                      );
                    },
                    child: const Text(
                      StringRes.createAccount,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SignInForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: const Text(
                      StringRes.forgotPassword,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  RoundedButton(
                    label: StringRes.signIn,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FirebaseAuth.instance.currentUser?.reload();
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
