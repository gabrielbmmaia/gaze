import 'package:flutter/material.dart';

import 'package:gaze/features/series/presentation/widgets/text_tag.dart';

class TextTagSlider extends StatelessWidget {
  const TextTagSlider({required this.textList, super.key});

  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: textList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextTag(
              text: textList[index],
            ),
          );
        },
      ),
    );
  }
}
