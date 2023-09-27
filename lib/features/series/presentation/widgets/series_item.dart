import 'package:flutter/material.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class SeriesItem extends StatefulWidget {
  const SeriesItem({
    required this.seriesModel,
    this.imageWidth = 225,
    this.imageHeight = 150,
    super.key,
  });

  final SeriesModel seriesModel;
  final double imageWidth;
  final double imageHeight;

  @override
  State<SeriesItem> createState() => _SeriesItemState();
}

class _SeriesItemState extends State<SeriesItem> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      height: widget.imageHeight,
      width: widget.imageWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            '$kImageBaseUrl${widget.seriesModel.posterPath}',
          ),
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          print(widget.seriesModel.name);
        },
      ),
    );
  }
}
