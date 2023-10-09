import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/views/series_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class SeriesItem extends StatefulWidget {
  const SeriesItem({
    required this.seriesModel,
    super.key,
  });

  final SeriesModel seriesModel;

  @override
  State<SeriesItem> createState() => _SeriesItemState();
}

class _SeriesItemState extends State<SeriesItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        Navigator.of(context).pushNamed(
          SeriesDetailsScreen.routeName,
          arguments: widget.seriesModel.id,
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colours.onPrimaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: '$kImageBaseUrl${widget.seriesModel.posterPath}',
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            imageErrorBuilder: (_, __, ___) {
              return const Center(
                child: Icon(
                  Icons.image_rounded,
                  color: Colours.neutralTextColour,
                  size: 60,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
