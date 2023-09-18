import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/rounded_button.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/core/utils/core_utils.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/auth/presentation/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
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
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as UserEntity);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  const Text(
                    StringRes.appTitle,
                    style: TextStyle(
                      fontFamily: Fonts.satisfy,
                      fontWeight: FontWeight.w700,
                      fontSize: 90,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        StringRes.signUpYourAcc,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(StringRes.alreadyHaveAcc),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SignUpForm(
                    emailController: emailController,
                    fullNameController: fullNameController,
                    formKey: formKey,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ),
                  const SizedBox(height: 30),
                  if (state is AuthLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    RoundedButton(
                      label: StringRes.createAccount,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        FirebaseAuth.instance.currentUser?.reload();
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                SignUpEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  fullName: fullNameController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
