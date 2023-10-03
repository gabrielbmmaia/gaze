import 'package:flutter/material.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/views/search_list_screen.dart';

class SeriesSearchScreen extends StatefulWidget {
  const SeriesSearchScreen({super.key});

  @override
  State<SeriesSearchScreen> createState() => _SeriesSearchScreenState();
}

class _SeriesSearchScreenState extends State<SeriesSearchScreen> {
  final genreList = [
    Genres.actionAdventure,
    Genres.animation,
    Genres.comedy,
    Genres.crime,
    Genres.documentary,
    Genres.drama,
    Genres.family,
    Genres.kids,
    Genres.mystery,
    Genres.reality,
    Genres.sciFiFantasy,
  ];

  final TextEditingController searchController = TextEditingController();

  List<Widget>? trailing = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SearchBar(
              controller: searchController,
              backgroundColor: MaterialStateProperty.all(
                Colours.onDefaultColor,
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
              hintText: 'Nome da série',
              hintStyle: MaterialStateProperty.all(
                const TextStyle(color: Colours.neutralTextColour),
              ),
              trailing: [
                IconButton(
                  onPressed: () {
                    context.push(
                      SearchListScreen(
                        args: NavigationSearchTypeArgs.textSearch(
                          searchController.text,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colours.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Colours.onDefaultColor,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            const Text(
              'Gêneros',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                for (final genre in genreList)
                  Padding(
                    padding: const EdgeInsets.only(right: 8, bottom: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colours.onDefaultColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        context.push(
                          SearchListScreen(
                            args: NavigationSearchTypeArgs.genreSearch(
                              genreIds[genre]!,
                            ),
                          ),
                        );
                      },
                      child: Text(genresName[genre]!),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
