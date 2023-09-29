import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_details_model.dart';
import 'package:gaze/features/series/presentation/widgets/text_tag.dart';

class SeriesDetailsHeader extends StatelessWidget {
  const SeriesDetailsHeader({required this.seriesDetails, super.key});

  final SeriesDetailsModel seriesDetails;

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
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
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
                          TextTag(text: '14'),
                          const SizedBox(width: 10),
                          Text(
                            seriesDetails.firstAirDate,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
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
