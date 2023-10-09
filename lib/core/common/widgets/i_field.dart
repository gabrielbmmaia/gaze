import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/string.dart';

/// [StatelessWidget] que serve como base para todos formulários do app.
class IField extends StatelessWidget {
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyBoardType,
    this.hintStyle,
    this.overrideValidator = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyBoardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
        if (value == null || value.isEmpty) {
          return StringRes.necessaryField;
        }
        return validator?.call(value);
      },
      keyboardType: keyBoardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(
            color: Colours.secondaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: filled,
        fillColor: fillColour,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400, color: Colors.white,
            ),
      ),
    );
  }
}
