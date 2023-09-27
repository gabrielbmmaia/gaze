import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/series/presentation/bloc/amazon/amazon_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/disney/disney_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/hbo/hbo_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/netflix/netflix_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/popular/popular_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/trending/trending_bloc.dart';
import 'package:gaze/features/series/presentation/widgets/series_list.dart';
import 'package:gaze/features/series/presentation/widgets/trending_slider.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  @override
  void initState() {
    context.read<PopularBloc>().add(const LoadPopularListEvent());
    context.read<TrendingBloc>().add(const LoadTrendingListEvent());
    context.read<TopRatedBloc>().add(const LoadTopRatedListEvent());
    context.read<NetflixBloc>().add(const LoadNetflixListEvent());
    context.read<AmazonBloc>().add(const LoadAmazonListEvent());
    context.read<DisneyBloc>().add(const LoadDisneyListEvent());
    context.read<HboBloc>().add(const LoadHboListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          StringRes.appTitle,
          style: TextStyle(
            fontFamily: Fonts.satisfy,
            fontSize: 26,
            color: Colors.amber,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TrendingBloc, TrendingState>(
                builder: (context, state) {
                  if (state is LoadedTrendingSeries) {
                    return TrendingSlider(trendingList: state.trendingList);
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<NetflixBloc, NetflixState>(
                builder: (context, state) {
                  if (state is LoadedNetflixSeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'Netflix',
                        seriesList: state.netflixList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<AmazonBloc, AmazonState>(
                builder: (context, state) {
                  if (state is LoadedAmazonSeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'Amazon',
                        seriesList: state.amazonList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<HboBloc, HboState>(
                builder: (context, state) {
                  if (state is LoadedHboSeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'HBO',
                        seriesList: state.hboList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<DisneyBloc, DisneyState>(
                builder: (context, state) {
                  if (state is LoadedDisneySeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'Disney+',
                        seriesList: state.disneyList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<TopRatedBloc, TopRatedState>(
                builder: (context, state) {
                  if (state is LoadedTopRatedSeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'Bem Avaliados',
                        seriesList: state.topRatedList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<PopularBloc, PopularState>(
                builder: (context, state) {
                  if (state is LoadedPopularSeries) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SeriesList(
                        title: 'Popular',
                        seriesList: state.popularList,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
