import 'package:flutter/material.dart';
import 'package:gaze/core/common/widgets/i_field.dart';
import 'package:gaze/core/res/string.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailController,
    required this.fullNameController,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          IField(
            controller: widget.fullNameController,
            hintText: StringRes.fullNameHint,
            keyBoardType: TextInputType.name,
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.emailController,
            hintText: StringRes.emailHint,
            keyBoardType: TextInputType.emailAddress,
            overrideValidator: true,
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
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 25),
          IField(
            controller: widget.confirmPasswordController,
            hintText: StringRes.confirmPasswordHint,
            obscureText: obscureConfirmPassword,
            keyBoardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscureConfirmPassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return StringRes.passwordDoNotMatch;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
