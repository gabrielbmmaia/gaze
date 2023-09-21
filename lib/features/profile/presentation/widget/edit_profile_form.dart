import 'package:flutter/material.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/extensions/string_extensions.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/profile/presentation/widget/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.bioController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: StringRes.fullNameHint,
          controller: fullNameController,
          hintText: context.currentUser!.fullName,
        ),
        EditProfileFormField(
          fieldTitle: StringRes.emailHint,
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileFormField(
          fieldTitle: StringRes.bioHint,
          controller: bioController,
          hintText: (context.currentUser!.bio != null)
              ? context.currentUser!.bio!
              : '',
        ),
      ],
    );
  }
}
