import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viz_it_app/states/image_search_state.dart';

class ImageSearchProvider extends StatelessWidget {
  final Widget child;

  ImageSearchProvider({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageSearchState>(
      create: (_) => ImageSearchState(),
      child: child,
    );
  }
}