import 'package:flutter/material.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

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
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: seriesList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 225,
                    width: 150,
                    child: Image.network(
                      '$kImageBaseUrl${seriesList[index].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
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
