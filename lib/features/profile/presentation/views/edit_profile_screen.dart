import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/app_background.dart';
import 'package:gaze/core/common/widgets/nested_back_button.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/media_res.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/core/utils/core_utils.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/profile/presentation/widget/edit_profile_form.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.currentUser!.fullName.trim() != fullNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get bioChanged =>
      context.currentUser!.bio?.trim() != bioController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged && !emailChanged && !bioChanged && !imageChanged;

  @override
  void initState() {
    fullNameController.text = context.currentUser!.fullName.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, StringRes.profileUpdate);
          context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colours.defaultColor,
          appBar: AppBar(
            backgroundColor: Colours.onDefaultColor,
            leading: const NestedBackButton(),
            title: const Text(
              'Editar Perfil',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final bloc = context.read<AuthBloc>();
                  if (emailChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.email,
                        userData: emailController.text.trim(),
                      ),
                    );
                  }
                  if (nameChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.fullName,
                        userData: fullNameController.text.trim(),
                      ),
                    );
                  }
                  if (imageChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.profilePic,
                        userData: pickedImage,
                      ),
                    );
                  }
                  if (bioChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.bio,
                        userData: bioController.text.trim(),
                      ),
                    );
                  }
                },
                child: state is AuthLoading
                    ? const Center(child: CircularProgressIndicator())
                    : StatefulBuilder(
                        builder: (_, refresh) {
                          fullNameController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          bioController.addListener(() => refresh(() {}));
                          return Text(
                            'Pronto',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? Colors.grey
                                  : Colours.secondaryColor,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: AppBackground(
            backgroundColor: Colours.defaultColor,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                Builder(
                  builder: (context) {
                    final user = context.currentUser!;
                    final userImage =
                        user.profilePic == null || user.profilePic!.isEmpty
                            ? null
                            : user.profilePic;
                    return Container(
                      width: 160,
                      height: 160,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: pickedImage != null
                              ? FileImage(pickedImage!)
                              : userImage != null
                                  ? NetworkImage(userImage)
                                  : const AssetImage(MediaRes.userProfile)
                                      as ImageProvider,
                          fit: BoxFit.contain,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(.6),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colours.secondaryColor,
                        ),
                        onPressed: pickImage,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    StringRes.recomendedImageSize,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colours.neutralTextColour,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                EditProfileForm(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  bioController: bioController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
