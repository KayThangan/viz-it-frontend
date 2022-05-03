import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../states/image_search_state.dart';
import '../theme/theme_manager.dart';

class ToggleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToggleWidgetState();
  }
}

class _ToggleWidgetState extends State<ToggleWidget> {
  int toggleIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: ToggleSwitch(
              minWidth: 200.0,
              cornerRadius: 8.0,
              activeBgColor: [theme.themeData!.primaryColor],
              activeFgColor: theme.themeData!.canvasColor,
              inactiveBgColor: theme.themeData!.canvasColor,
              inactiveFgColor: Colors.black.withOpacity(0.42),
              initialLabelIndex: toggleIndex,
              totalSwitches: 2,
              labels: ['Original Image', 'Mask Image'],
              radiusStyle: true,
              onToggle: (index) {
                print("toggle index:" + index.toString());
                setState(() {
                  toggleIndex = index!;
                });
              },
            ),
          ),
        ),
        toggleIndex == 0
            ? Image.memory(
                base64.decode(ImageSearchState.imageSearch.image),
                width: double.infinity,
              )
            : Image.memory(
                base64.decode(ImageSearchState.imageSearch.resultImage),
                width: double.infinity,
              ),
      ],
    );
  }
}
