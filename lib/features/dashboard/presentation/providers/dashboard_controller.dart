import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/views/persistent_view.dart';
import 'package:gaze/core/providers/tab_navigator.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/profile/presentation/views/profile_screen.dart';
import 'package:gaze/features/series/presentation/bloc/amazon/amazon_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/netflix/netflix_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/popular/popular_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/trending/trending_bloc.dart';
import 'package:gaze/features/series/presentation/views/series_screen.dart';
import 'package:provider/provider.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];

  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<PopularBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<TrendingBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<TopRatedBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<NetflixBloc>(),
              ),
              BlocProvider(
                create: (_) => sl<AmazonBloc>(),
              ),
            ],
            child: const SeriesScreen(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const ProfileScreen())),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
