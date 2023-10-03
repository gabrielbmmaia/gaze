import 'package:flutter/material.dart';
import 'package:gaze/core/common/widgets/i_field.dart';
import 'package:gaze/core/res/string.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.emailController,
            hintText: StringRes.emailHint,
            keyBoardType: TextInputType.emailAddress,
            validator: (value) {
              if (value != null) {
                if (!value.contains('@') || !value.contains('.com')) {
                  return StringRes.notAnEmail;
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.passwordController,
            hintText: StringRes.passwordHint,
            obscureText: obscurePassword,
            keyBoardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
