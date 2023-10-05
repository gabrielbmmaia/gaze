import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({
    required this.seriesList,
    super.key,
  });

  final List<SeriesModel> seriesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: seriesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: AspectRatio(
                  aspectRatio: 500 / 750,
                  child: SeriesItem(
                    seriesModel: seriesList[index],
                    backgroundColor: Colours.onDefaultColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
