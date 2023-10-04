import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/series/presentation/bloc/amazon/amazon_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/apple/apple_bloc.dart';
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
    context.read<AppleBloc>().add(const LoadAppleListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        title: const Text(
          StringRes.appTitle,
          style: TextStyle(
            fontFamily: Fonts.satisfy,
            fontSize: 26,
            color: Colours.secondaryColor,
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          if (state is LoadedTrendingSeries)
                            TrendingSlider(trendingList: state.trendingList)
                          else
                            const Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color: Colours.secondaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<NetflixBloc, NetflixState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedNetflixSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Netflix',
                              seriesList: state.netflixList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AmazonBloc, AmazonState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedAmazonSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Amazon Prime',
                              seriesList: state.amazonList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<HboBloc, HboState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedHboSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'HBO Max',
                              seriesList: state.hboList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<DisneyBloc, DisneyState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedDisneySeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Disney+',
                              seriesList: state.disneyList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AppleBloc, AppleState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedAppleSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Apple TV+',
                              seriesList: state.appleList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<TopRatedBloc, TopRatedState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedTopRatedSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Bem Avaliados',
                              seriesList: state.topRatedList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<PopularBloc, PopularState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        if (state is LoadedPopularSeries)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: SeriesList(
                              title: 'Popular',
                              seriesList: state.popularList,
                            ),
                          )
                        else
                          const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
