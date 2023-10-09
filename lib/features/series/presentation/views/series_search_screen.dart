import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/fonts.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/series/presentation/bloc/searched/series_list_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/views/series_list_screen.dart';

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
      backgroundColor: Colours.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SearchBar(
              controller: searchController,
              backgroundColor: MaterialStateProperty.all(
                Colours.onPrimaryColor,
              ),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                  fontFamily: Fonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
              ),
              hintText: 'Nome da série',
              hintStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colours.neutralTextColour,
                  fontFamily: Fonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: [
                IconButton(
                  onPressed: () {
                    context.push(
                      BlocProvider(
                        create: (_) => sl<SeriesListBloc>(),
                        child: SeriesListScreen(
                          args: NavigationSearchTypeArgs.textSearch(
                            searchController.text.trim(),
                          ),
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
              color: Colours.onPrimaryColor,
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
                            MaterialStateProperty.all(Colours.onPrimaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(fontFamily: Fonts.poppins),
                        ),
                      ),
                      onPressed: () {
                        context.push(
                          BlocProvider(
                            create: (_) => sl<SeriesListBloc>(),
                            child: SeriesListScreen(
                              args: NavigationSearchTypeArgs.genreSearch(genre),
                            ),
                          ),
                        );
                      },
                      child: Text(getGenresName[genre]!),
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
