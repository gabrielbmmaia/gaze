import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/auth/presentation/views/sign_in_screen.dart';
import 'package:gaze/features/auth/presentation/views/sign_up_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
