import 'package:flutter/material.dart';
import 'package:gaze/features/series/domain/models/youtube_trailers_model.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailersItem extends StatelessWidget {
  const TrailersItem({required this.trailer, super.key});

  final YoutubeTrailersModel trailer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Ink(
          height: 130,
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: NetworkImage(
                'https://img.youtube.com/vi/${trailer.trailerKey}/0.jpg',
              ),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () async {
              final youtubeUrl = Uri.parse(
                'https://www.youtube.com/embed/${trailer.trailerKey}',
              );
              if (await canLaunchUrl(youtubeUrl)) {
                await launchUrl(youtubeUrl);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
          child: Text(
            trailer.trailerTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
