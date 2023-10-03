import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.onDefaultColor,
        title: const Text(
          'Em construção',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colours.defaultColor,
      body: SafeArea(
        child: Center(
          child: Lottie.asset('asset/lottie/page_under_construction.json'),
        ),
      ),
    );
  }
}
