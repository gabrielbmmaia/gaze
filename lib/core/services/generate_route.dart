import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/views/page_under_construction.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/auth/presentation/views/sign_in_screen.dart';
import 'package:gaze/features/auth/presentation/views/sign_up_screen.dart';
import 'package:gaze/features/dashboard/presentation/views/dashboard.dart';
import 'package:gaze/features/series/presentation/bloc/popular/popular_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/series_details/series_details_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/yt_trailers/yt_trailers_bloc.dart';
import 'package:gaze/features/series/presentation/views/series_details_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (context) {
          if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final userEntity = UserEntity(
              uid: user.uid,
              email: user.email ?? '',
              fullName: user.displayName ?? '',
            );

            context.userProvider.initUser(userEntity);
            return const DashboardScreen();
          }

          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );

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

    case DashboardScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<PopularBloc>(),
          child: const DashboardScreen(),
        ),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );

    case SeriesDetailsScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<SeriesDetailsBloc>()),
            BlocProvider(create: (_) => sl<YtTrailersBloc>()),
          ],
          child: SeriesDetailsScreen(seriesId: settings.arguments as String),
        ),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
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
