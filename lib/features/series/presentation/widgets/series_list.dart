import 'package:flutter/material.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({
    required this.title,
    required this.seriesList,
    super.key,
  });

  final String title;
  final List<SeriesModel> seriesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ),
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
                child: SeriesItem(
                  seriesModel: seriesList[index],
                  imageHeight: 225,
                  imageWidth: 150,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
