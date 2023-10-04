import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/common/widgets/nested_back_button.dart';
import 'package:gaze/core/enums/genres.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/presentation/bloc/genre/genre_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({required this.args, super.key});

  final NavigationSearchTypeArgs args;

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  @override
  void initState() {
    if (widget.args.searchType == SearchType.genre) {
      context
          .read<GenreBloc>()
          .add(LoadGenreListEvent(genreId: widget.args.genreId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        title: Text(
          widget.args.searchType == SearchType.genre
              ? genreNameFromId[widget.args.genreId]!
              : widget.args.searchText,
        ),
        leading: const NestedBackButton(),
      ),
      body: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoadedGenreList)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 40,
                            crossAxisSpacing: 20,
                            childAspectRatio: 500 / 750),
                    itemCount: state.genreList.length,
                    itemBuilder: (context, index) {
                      return SeriesItem(seriesModel: state.genreList[index]);
                    },
                  ),
                )
              else
                const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colours.secondaryColor,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
