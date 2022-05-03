import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../theme/theme_manager.dart';

PersistentBottomSheetController BuildBottomSheetWidget(
    BuildContext context, String searchQuery) {
  final ThemeManager theme = Provider.of<ThemeManager>(context, listen: false);
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
  return showBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Container(
            decoration: BoxDecoration(
                color: theme.themeData?.canvasColor,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Container(
                padding: EdgeInsets.only(top: 8),
                child: WebView(
                  gestureRecognizers: gestureRecognizers,
                  initialUrl: 'https://www.google.com/search?q=' + searchQuery,
                )),
          ),
        );
      });
}
