import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/bloc/searched/series_list_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/views/series_list_screen.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class SeriesList extends StatelessWidget {
  const SeriesList({
    required this.title,
    required this.seriesList,
    this.network,
    super.key,
  });

  final Networks? network;
  final String title;
  final List<SeriesModel> seriesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              if(network != null)
              IconButton(
                onPressed: () {
                  context.push(
                    BlocProvider(
                      create: (_) => sl<SeriesListBloc>(),
                      child: SeriesListScreen(
                        args: NavigationSearchTypeArgs.networkSearch(network),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
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
