import 'package:flutter/material.dart';
import 'package:gaze/core/extensions/string_extensions.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/presentation/widgets/text_tag.dart';

class SeriesDetailsHeader extends StatelessWidget {
  const SeriesDetailsHeader({
    required this.seriesDetails,
    required this.classification,
    super.key,
  });

  final SeriesDetailsModel seriesDetails;
  final String? classification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    '$kImageBaseUrl${seriesDetails.backdropPath}',
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colours.defaultColor,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
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
                        '$kImageBaseUrl${seriesDetails.posterPath}',
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
                        Text(
                          seriesDetails.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.aeonik,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            if (classification != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextTag(
                                  text: (classification == '18')
                                      ? '+${classification!}'
                                      : classification!,
                                  backgroundColor: (classification == 'L')
                                      ? const Color(0xFF08B155)
                                      : (classification == '10')
                                          ? const Color(0xFF0E7DBF)
                                          : (classification == '12')
                                              ? const Color(0xFFF6C211)
                                              : (classification == '14')
                                                  ? const Color(0xFFE37722)
                                                  : (classification == '16')
                                                      ? const Color(0xFFD92826)
                                                      : (classification == '18')
                                                          ? const Color(
                                                              0xFF1D1815,
                                                            )
                                                          : Colours
                                                              .onDefaultColor,
                                ),
                              ),
                            if (seriesDetails.firstAirDate != null)
                              Text(
                                seriesDetails.firstAirDate!.getYear,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            if (seriesDetails.lastAirDate != null)
                              Text(
                                seriesDetails.inProduction
                                    ? ' • Em produção'
                                    : ' • ${seriesDetails.lastAirDate!.getYear}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
