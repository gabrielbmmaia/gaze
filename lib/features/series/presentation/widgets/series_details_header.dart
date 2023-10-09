import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/extensions/string_extensions.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/features/auth/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/widgets/text_tag.dart';
import 'package:iconly/iconly.dart';

class SeriesDetailsHeader extends StatefulWidget {
  const SeriesDetailsHeader({
    required this.seriesDetails,
    required this.classification,
    required this.isFavorite,
    super.key,
  });

  final SeriesDetailsModel seriesDetails;
  final String? classification;
  final bool? isFavorite;

  @override
  State<SeriesDetailsHeader> createState() => _SeriesDetailsHeaderState();
}

class _SeriesDetailsHeaderState extends State<SeriesDetailsHeader> {
  @override
  void initState() {
    _isFavorite = widget.isFavorite ?? false;
    super.initState();
  }

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is AddedOrRemovedItem) {
          _isFavorite = state.isFavorite;
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '$kImageBaseUrl${widget.seriesDetails.backdropPath}',
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colours.primaryColor,
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              left: 20,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 225,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(
                          '$kImageBaseUrl${widget.seriesDetails.posterPath}',
                        ),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                context.read<FavoriteBloc>().add(
                                      AddOrRemoveFavoriteItemEvent(
                                        seriesModel: SeriesModel(
                                          posterPath:
                                              widget.seriesDetails.posterPath,
                                          id: widget.seriesDetails.id,
                                          name: widget.seriesDetails.name,
                                        ),
                                      ),
                                    );
                              },
                              icon: Icon(
                                _isFavorite
                                    ? IconlyBold.star
                                    : IconlyLight.star,
                                color: Colours.secondaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.seriesDetails.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: Fonts.aeonik,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              if (widget.classification != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextTag(
                                    text: (widget.classification == '18')
                                        ? '+${widget.classification!}'
                                        : widget.classification!,
                                    backgroundColor: (widget.classification ==
                                            'L')
                                        ? const Color(0xFF08B155)
                                        : (widget.classification == '10')
                                            ? const Color(0xFF0E7DBF)
                                            : (widget.classification == '12')
                                                ? const Color(0xFFF6C211)
                                                : (widget.classification ==
                                                        '14')
                                                    ? const Color(0xFFE37722)
                                                    : (widget.classification ==
                                                            '16')
                                                        ? const Color(
                                                            0xFFD92826)
                                                        : (widget.classification ==
                                                                '18')
                                                            ? const Color(
                                                                0xFF1D1815,
                                                              )
                                                            : Colours
                                                                .onPrimaryColor,
                                  ),
                                ),
                              if (widget.seriesDetails.firstAirDate != null)
                                Text(
                                  widget.seriesDetails.firstAirDate!.getYear,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (widget.seriesDetails.lastAirDate != null)
                                Text(
                                  widget.seriesDetails.inProduction
                                      ? ' • Em produção'
                                      : ' • ${widget.seriesDetails.lastAirDate!.getYear}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
