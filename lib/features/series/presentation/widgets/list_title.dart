import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaze/core/enums/networks.dart';
import 'package:gaze/core/extensions/context_extension.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/series/presentation/bloc/searched/series_list_bloc.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';
import 'package:gaze/features/series/presentation/views/series_list_screen.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({required this.title, this.network, super.key});

  final String title;
  final Networks? network;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          if(network != null)
          IconButton(
            onPressed: () {
              context.push(
                BlocProvider(
                  create: (_) => sl<SeriesListBloc>(),
                  child: SeriesListScreen(
                    args: NavigationSearchTypeArgs.networkSearch(network),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
