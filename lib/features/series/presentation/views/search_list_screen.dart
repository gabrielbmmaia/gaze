import 'package:flutter/material.dart';
import 'package:gaze/core/common/widgets/nested_back_button.dart';
import 'package:gaze/core/res/colours.dart';
import 'package:gaze/features/series/presentation/enum/search_type.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({required this.args, super.key});

  final NavigationSearchTypeArgs args;

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.defaultColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colours.onDefaultColor,
        leading: const NestedBackButton(),
      ),
      body: Text('${widget.args.searchText} ${widget.args.genreId}',style: TextStyle(color: Colors.white),),
    );
  }
}
