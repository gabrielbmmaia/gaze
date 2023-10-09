import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/core/res/string.dart';
import 'package:gaze/features/auth/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:gaze/features/profile/presentation/widget/profile_app_bar.dart';
import 'package:gaze/features/profile/presentation/widget/profile_header.dart';
import 'package:gaze/features/series/presentation/widgets/list_error.dart';
import 'package:gaze/features/series/presentation/widgets/series_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(const LoadFavoriteSeriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      backgroundColor: Colours.defaultColor,
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 10),
              if (state is LoadedFavoriteSeries)
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 500 / 750,
                    ),
                    itemCount: state.favoriteList.length,
                    itemBuilder: (context, index) {
                      return SeriesItem(seriesModel: state.favoriteList[index]);
                    },
                  ),
                )
              else if (state is ErrorFavoriteSeries)
                ListError(
                  errorMessage: StringRes.connectionProblemMessage,
                  onPressed: () {
                    context.read<FavoriteBloc>().add(
                          const LoadFavoriteSeriesEvent(),
                        );
                  },
                )
              else
                const Expanded(
                  child: Align(
                    child: Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colours.secondaryColor,
                        ),
                      ),
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
