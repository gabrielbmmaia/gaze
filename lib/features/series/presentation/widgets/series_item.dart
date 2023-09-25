import 'package:flutter/material.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesItem extends StatelessWidget {
  const SeriesItem({required this.seriesModel, super.key});

  final SeriesModel seriesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          '$kImageBaseUrl${seriesModel.posterPath}',
          width: 150,
          height: 225,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
        Text(seriesModel.name),
      ],
    );
  }
}
