import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class TrendingSlider extends StatefulWidget {
  const TrendingSlider({required this.trendingList, super.key});

  final List<SeriesModel> trendingList;

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: widget.trendingList.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          enlargeCenterPage: true,
          pageSnapping: true,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return SeriesItem(
            seriesModel: widget.trendingList[itemIndex],
            imageHeight: 250,
            imageWidth: 200,
          );
        },
      ),
    );
  }
}
