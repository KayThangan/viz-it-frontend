import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';

class BuildBottomNavBar extends StatelessWidget {
  final VoidCallback onUploadSelected;
  final VoidCallback onLiveSelected;

  BuildBottomNavBar({required this.onUploadSelected, required this.onLiveSelected});

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 75,
      color: theme.themeData?.canvasColor,
      child: Row(
        children: [
          Container(
            width: screenWidth / 2,
            height: 75,
            child: FlatButton(
              onPressed: () => onLiveSelected(),
              child: Text(
                "Live",
                style: theme.themeData?.textTheme.headlineLarge,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.themeData?.primaryColor ?? Colors.transparent,
              ),
            ),
          ),
          Container(
            width: screenWidth / 2,
            height: 75,
            child: FlatButton(
              onPressed: () => onUploadSelected(),
              child: Text(
                "Upload",
                style: theme.themeData?.textTheme.headlineLarge,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.themeData?.primaryColor ?? Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
