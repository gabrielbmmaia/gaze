import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/providers/tab_navigator.dart';
import 'package:gaze/core/providers/user_provider.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';

extension ContextExt on BuildContext {

  UserProvider get userProvider => read<UserProvider>();

  UserModel? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();

  // Pop de NestedViews
  void pop() => tabNavigator.pop();

  // Push de NestedViews
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
