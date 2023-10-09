import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/enums/networks.dart';
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
import 'package:gaze/features/series/presentation/widgets/list_error.dart';
import 'package:gaze/features/series/presentation/widgets/list_title.dart';
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
    context
        .read<NetflixBloc>()
        .add(const LoadNetflixListEvent(Networks.netflix));
    context.read<AmazonBloc>().add(const LoadAmazonListEvent(Networks.amazon));
    context.read<DisneyBloc>().add(const LoadDisneyListEvent(Networks.disney));
    context.read<HboBloc>().add(const LoadHboListEvent(Networks.hbo));
    context.read<AppleBloc>().add(const LoadAppleListEvent(Networks.apple));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primaryColor,
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
                      child: Column(
                        children: [
                          if (state is LoadedTrendingSeries)
                            TrendingSlider(trendingList: state.trendingList)
                          else if (state is ErrorTrendingSeries)
                            ListError(
                              errorMessage: StringRes.connectionProblemMessage,
                              onPressed: () {
                                context.read<TrendingBloc>().add(
                                      const LoadTrendingListEvent(),
                                    );
                              },
                            )
                          else
                            const Expanded(
                              child: Align(
                                child: Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: Colours.secondaryColor,
                                    ),
                                  ),
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
                    child: Column(
                      children: [
                        const ListTitle(
                          title: 'Netflix',
                          network: Networks.netflix,
                        ),
                        if (state is LoadedNetflixSeries)
                          SeriesList(seriesList: state.netflixList)
                        else if (state is ErrorNetflixSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<NetflixBloc>().add(
                                    const LoadNetflixListEvent(
                                      Networks.netflix,
                                    ),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                    child: Column(
                      children: [
                        const ListTitle(
                          title: 'Amazon',
                          network: Networks.amazon,
                        ),
                        if (state is LoadedAmazonSeries)
                          SeriesList(seriesList: state.amazonList)
                        else if (state is ErrorAmazonSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<AmazonBloc>().add(
                                    const LoadAmazonListEvent(Networks.amazon),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
                    child: Column(
                      children: [
                        const ListTitle(
                          title: 'HBO Max',
                          network: Networks.hbo,
                        ),
                        if (state is LoadedHboSeries)
                          SeriesList(seriesList: state.hboList)
                        else if (state is ErrorHboSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<HboBloc>().add(
                                    const LoadHboListEvent(Networks.hbo),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
                    child: Column(
                      children: [
                        const ListTitle(
                          title: 'Disney+',
                          network: Networks.disney,
                        ),
                        if (state is LoadedDisneySeries)
                          SeriesList(seriesList: state.disneyList)
                        else if (state is ErrorDisneySeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<DisneyBloc>().add(
                                    const LoadDisneyListEvent(Networks.disney),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
                    child: Column(
                      children: [
                        const ListTitle(
                          title: 'Apple TV+',
                          network: Networks.apple,
                        ),
                        if (state is LoadedAppleSeries)
                          SeriesList(seriesList: state.appleList)
                        else if (state is ErrorAppleSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<AppleBloc>().add(
                                    const LoadAppleListEvent(Networks.apple),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
                    child: Column(
                      children: [
                        const ListTitle(title: 'Bem Avaliados'),
                        if (state is LoadedTopRatedSeries)
                          SeriesList(seriesList: state.topRatedList)
                        else if (state is ErrorTopRatedSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<TopRatedBloc>().add(
                                    const LoadTopRatedListEvent(),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
                    child: Column(
                      children: [
                        const ListTitle(title: 'Popular'),
                        if (state is LoadedPopularSeries)
                          SeriesList(seriesList: state.popularList)
                        else if (state is ErrorPopularSeries)
                          ListError(
                            errorMessage: StringRes.connectionProblemMessage,
                            onPressed: () {
                              context.read<PopularBloc>().add(
                                    const LoadPopularListEvent(),
                                  );
                            },
                          )
                        else
                          const Expanded(
                            child: Align(
                              child: Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Colours.secondaryColor,
                                  ),
                                ),
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
