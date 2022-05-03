import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viz_it_app/viz_it.dart';

Future main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp((VizIt()));
}
