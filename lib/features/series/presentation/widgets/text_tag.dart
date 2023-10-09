import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';

class TextTag extends StatelessWidget {
  const TextTag({
    required this.text,
    this.backgroundColor = Colours.onPrimaryColor,
    super.key,
  });

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
