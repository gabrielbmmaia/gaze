import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/popup_item.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/profile/presentation/views/edit_profile_screen.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      backgroundColor: Colours.onPrimaryColor,
      title: const Text(
        'Perfil',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        PopupMenuButton(
          surfaceTintColor: Colors.white70,
          offset: const Offset(0, 50),
          icon: const Icon(Icons.more_horiz, color: Colors.white,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              onTap: () {
                Navigator.of(context).pushNamed('fake-error');
              },
              child: const PopupItem(
                title: 'Fake Nav Error',
                icon: Icon(
                  Icons.bug_report_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () => context.push(
                BlocProvider(
                  create: (_) => sl<AuthBloc>(),
                  child: const EditProfileScreen(),
                ),
              ),
              child: const PopupItem(
                title: 'Editar Perfil',
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                endIndent: 16,
                indent: 16,
              ),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                final navigator = Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
              child: const PopupItem(
                title: 'Sair',
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
