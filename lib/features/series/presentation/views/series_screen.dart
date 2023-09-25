import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/series/presentation/bloc/series_bloc.dart';
import 'package:gaze/features/series/presentation/widgets/series_list.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  @override
  void initState() {
    context.read<SeriesBloc>().add(const LoadPopularListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          StringRes.appTitle,
          style: TextStyle(
            fontFamily: Fonts.satisfy,
            fontSize: 26,
            color: Colors.amber,
          ),
        ),
      ),
      body: BlocConsumer<SeriesBloc, SeriesState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: 10,
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
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 200,
                            height: 300,
                            color: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (state is LoadedPopularSeries)
                    SeriesList(title: 'Popular', seriesList: state.popularList),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
