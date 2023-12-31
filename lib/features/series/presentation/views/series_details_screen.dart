import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/extensions/string_extensions.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/utils/core_utils.dart';
import 'package:gaze/features/auth/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/bloc/classification/classification_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/series_details/series_details_bloc.dart';
import 'package:gaze/features/series/presentation/bloc/yt_trailers/yt_trailers_bloc.dart';
import 'package:gaze/features/series/presentation/widgets/seasons_item.dart';
import 'package:gaze/features/series/presentation/widgets/series_details_header.dart';
import 'package:gaze/features/series/presentation/widgets/text_tag_slider.dart';
import 'package:gaze/features/series/presentation/widgets/trailers_item.dart';

class SeriesDetailsScreen extends StatefulWidget {
  const SeriesDetailsScreen({
    required this.seriesId,
    super.key,
  });

  static const routeName = '/series-details';
  final String seriesId;

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  @override
  void initState() {
    context
        .read<SeriesDetailsBloc>()
        .add(LoadSeriesDetailsEvent(seriesId: widget.seriesId));
    context
        .read<YtTrailersBloc>()
        .add(LoadYtTrailersEvent(seriesId: widget.seriesId));
    context
        .read<ClassificationBloc>()
        .add(LoadClassificationEvent(seriesId: widget.seriesId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colours.primaryColor,
      body: BlocConsumer<SeriesDetailsBloc, SeriesDetailsState>(
        listener: (context, state) {
          if (state is LoadedSeriesDetails) {
            final model = state.seriesDetails;
            context.read<FavoriteBloc>().add(
                  IsFavoriteItemEvent(
                    seriesModel: SeriesModel(
                      name: model.name,
                      posterPath: model.posterPath,
                      id: model.id,
                    ),
                  ),
                );
          }
          if (state is ErrorSeriesDetails) {
            Future.delayed(const Duration(seconds: 1), () {
              CoreUtils.showSnackBar(context, state.errorMessage);
              Navigator.pop(context);
            });
          }
        },
        builder: (context, state) {
          final classificationState = context.watch<ClassificationBloc>().state;
          final favoriteState = context.watch<FavoriteBloc>().state;
          return CustomScrollView(
            slivers: [
              if (state is LoadedSeriesDetails) ...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SeriesDetailsHeader(
                        seriesDetails: state.seriesDetails,
                        classification:
                            (classificationState is LoadedClassification)
                                ? classificationState.classification
                                : null,
                        isFavorite: (favoriteState is IsFavoriteItem)
                            ? favoriteState.isFavorite
                            : null,
                      ),
                      const Divider(
                        height: 1,
                        color: Colours.onPrimaryColor,
                        thickness: 1,
                        indent: 14,
                        endIndent: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.seriesDetails.tagline.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  state.seriesDetails.tagline,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            Text(
                              textAlign: TextAlign.justify,
                              state.seriesDetails.overview,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Gêneros',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextTagSlider(textList: state.seriesDetails.genres),
                            const SizedBox(height: 10),
                            const Text(
                              'Redes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextTagSlider(
                              textList: state.seriesDetails.networks,
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 1,
                              color: Colours.onPrimaryColor,
                              thickness: 1,
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Titulo Original',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.seriesDetails.originalName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Idioma Original',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.seriesDetails.originalLanguage
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Primeira exibição',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (state.seriesDetails.firstAirDate !=
                                        null)
                                      Expanded(
                                        child: Text(
                                          state.seriesDetails.firstAirDate!
                                              .toBrazilianDate,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Última exibição',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (state.seriesDetails.lastAirDate != null)
                                      Expanded(
                                        child: Text(
                                          state.seriesDetails.lastAirDate!
                                              .toBrazilianDate,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Episódios',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.seriesDetails.episodes.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Temporadas',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.seriesDetails.seasons.length
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Divider(
                              height: 1,
                              color: Colours.onPrimaryColor,
                              thickness: 1,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Temporadas',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 280,
                              child: ListView.builder(
                                itemCount: state.seriesDetails.seasons.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: SeasonsItem(
                                      seasonsModel:
                                          state.seriesDetails.seasons[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            BlocBuilder<YtTrailersBloc, YtTrailersState>(
                              builder: (context, state) {
                                if (state is LoadedYtTrailers) {
                                  if (state.trailersList.isNotEmpty) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(
                                          height: 1,
                                          color: Colours.onPrimaryColor,
                                          thickness: 1,
                                        ),
                                        const SizedBox(height: 15),
                                        const Text(
                                          'Mídias',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            itemCount:
                                                state.trailersList.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: TrailersItem(
                                                  trailer:
                                                      state.trailersList[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
