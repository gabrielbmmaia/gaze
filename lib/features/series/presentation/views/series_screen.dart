import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/res/string.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
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
      body: SafeArea(
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
              const Text(
                'Popular',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        color: Colors.amber,
                        height: 200,
                        width: 200,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
