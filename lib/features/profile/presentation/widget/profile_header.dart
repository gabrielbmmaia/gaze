import 'package:flutter/material.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/media_res.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;

        return Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colours.onPrimaryColor,
              radius: 80,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.userProfile) as ImageProvider,
            ),
            const SizedBox(height: 20),
            Text(
              user?.fullName ?? 'No user',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white),
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              Text(
                user.bio!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colours.neutralTextColour),
              ),
            ],
          ],
        );
      },
    );
  }
}
