import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/presentation/widgets/series_details_header.dart';

class SeriesDetailsScreen extends StatelessWidget {
  const SeriesDetailsScreen({super.key});

  static const routeName = '/series-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.defaultColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              expandedHeight: kToolbarHeight,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SeriesDetailsHeader(),
                Divider(
                  height: 1,
                  color: Colours.onDefaultColor,
                  thickness: 1,
                  indent: 14,
                  endIndent: 14,
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'O futuro começa.',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'O futuro começa oiasjdoi jasdoij wijd nsianwodn oainsdoqn sknd lqkwnd aisodnoiqnd nddnslançGS DNSOod ndosnoan.',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}
