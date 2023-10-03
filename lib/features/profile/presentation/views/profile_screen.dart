import 'package:flutter/material.dart';
import 'package:gaze/core/common/widgets/app_background.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/profile/presentation/widget/profile_app_bar.dart';
import 'package:gaze/features/profile/presentation/widget/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: AppBackground(
        backgroundColor: Colours.defaultColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
          ],
        ),
      ),
    );
  }
}
