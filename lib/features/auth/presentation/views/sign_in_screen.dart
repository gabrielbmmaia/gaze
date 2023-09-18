import 'package:flutter/material.dart';
import 'package:gaze/core/common/widgets/rounded_button.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/auth/presentation/views/sign_up_screen.dart';
import 'package:gaze/features/auth/presentation/widgets/sign_in_form.dart';

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
      body: SafeArea(
        child: Center(
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
                    Navigator.pushReplacementNamed(
                      context,
                      SignUpScreen.routeName,
                    );
                  },
                  child: const Text(
                    StringRes.createAccount,
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontSize: 16,
                    ),
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
                  onPressed: () {},
                  child: const Text(
                    StringRes.forgotPassword,
                    style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RoundedButton(label: StringRes.signIn, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
