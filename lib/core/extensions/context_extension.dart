import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/providers/user_provider.dart';



extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  UserProvider get userProvider => read<UserProvider>();
}
